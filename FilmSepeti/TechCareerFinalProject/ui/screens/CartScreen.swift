import Foundation
import SwiftUI

struct CartScreen: View {
    @EnvironmentObject var cartVM: CartViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var searchQuery = ""
    @State private var pendingDeletionGroup: CartViewModel.CartGroup? = nil

    private var canCheckout: Bool {
        !cartVM.filteredGroups.isEmpty && cartVM.errorText == nil && !cartVM.isLoading
    }

    var body: some View {
        Group {
            if cartVM.isLoading {
                ProgressView("Sepet yükleniyor...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)

            } else if let error = cartVM.errorText {
                VStack(spacing: 12) {
                    Text("Sepet alınamadı.")
                    Text(error).font(.caption).foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            } else if cartVM.filteredGroups.isEmpty {
                ContentUnavailableView(
                    "Sepetiniz boş",
                    systemImage: "cart",
                    description: Text("Film eklemek için ana ekrana dönebilirsiniz.")
                )

            } else {
                List {
                    ForEach(cartVM.filteredGroups) { group in
                        HStack {
                            PosterView(path: group.image).frame(width: 56, height: 56)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(group.name).font(.headline)
                                Text("Adet: x\(group.qty)").font(.caption).foregroundStyle(.secondary)
                            }
                            Spacer()
                            VStack(alignment: .trailing, spacing: 2) {
                                Text(AppTheme.price(group.total)).bold()
                                Text(AppTheme.price(group.unitPrice)).font(.caption2).foregroundStyle(.secondary)
                            }
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button { Task { await cartVM.decrementOne(from: group) } } label: { Image(systemName: "minus") }
                                .tint(.gray)
                            Button(role: .destructive) { pendingDeletionGroup = group } label: { Image(systemName: "trash") }
                                .tint(.red)
                        }
                    }

                    HStack {
                        Text("Toplam").font(.headline)
                        Spacer()
                        Text(AppTheme.price(cartVM.total)).bold()
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Sepetim")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button { dismiss() } label: { Image(systemName: "chevron.left") }
            }
        }
        .searchable(text: $searchQuery, placement: .navigationBarDrawer, prompt: "Sepette ara")
        .onChange(of: searchQuery) { _, q in cartVM.applySearch(q) }
        .onAppear {
            searchQuery = ""
            Task { await cartVM.refresh() }
        }
        .refreshable { await cartVM.refresh() }
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 0) {
                Divider().opacity(0.3)
                Button { } label: {
                    Text(canCheckout ? "Sepeti Onayla" : "Sepetiniz boş")
                        .font(.headline)
                        .frame(maxWidth: .infinity).frame(height: 56)
                }
                .buttonStyle(.borderedProminent)
                .tint(AppTheme.primary)
                .disabled(!canCheckout)
                .opacity(canCheckout ? 1 : 0.6)
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(.ultraThinMaterial)
            }
        }
        .confirmationDialog(
            "Bu film grubundaki tüm ürünler silinsin mi?",
            isPresented: Binding(
                get: { pendingDeletionGroup != nil },
                set: { if !$0 { pendingDeletionGroup = nil } }
            ),
            titleVisibility: .visible
        ) {
            if let group = pendingDeletionGroup {
                Button("Evet, tümünü sil", role: .destructive) {
                    Task {
                        await cartVM.removeAll(in: group)
                        pendingDeletionGroup = nil
                    }
                }
            }
            Button("Vazgeç", role: .cancel) { pendingDeletionGroup = nil }
        }
    }
}
