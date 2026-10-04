import SwiftUI

struct MovieDetailScreen: View {
    let movie: Movie
    @EnvironmentObject var cartVM: CartViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var quantity: Int = 1
    @State private var isDescriptionExpanded = false

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.black, Color.black.opacity(0.92)],
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 16) {
                        AsyncImage(url: MoviesRepository.imageURL(for: movie.image)) { phase in
                            switch phase {
                            case .empty:
                                ZStack { Rectangle().fill(.secondary.opacity(0.15)); ProgressView() }
                            case .success(let img):
                                img.resizable().scaledToFill()
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable().scaledToFit()
                                    .padding(24)
                                    .foregroundStyle(.secondary)
                            @unknown default:
                                Color.clear
                            }
                        }
                        .frame(height: 360)
                        .clipShape(RoundedRectangle(cornerRadius: 16))

                        Text(movie.name)
                            .font(.largeTitle.bold())
                            .lineLimit(2)

                        HStack(spacing: 12) {
                            Label("\(movie.year)", systemImage: "calendar")
                            Text("•")
                            Label(movie.director, systemImage: "person").lineLimit(1)
                            if !movie.category.isEmpty {
                                Text("•")
                                Label(movie.category, systemImage: "tag").lineLimit(1)
                            }
                        }
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                        HStack {
                            RatingBadge(value: movie.rating)
                            Spacer()
                            Text(AppTheme.price(movie.price))
                                .font(.footnote.weight(.semibold))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(.ultraThinMaterial, in: Capsule())
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Açıklama").font(.headline)
                            Text(movie.description.isEmpty
                                 ? "Bu film için detay açıklama verilmemiş."
                                 : movie.description)
                                .font(.body)
                                .lineLimit(isDescriptionExpanded ? nil : 3)
                                .animation(.easeInOut, value: isDescriptionExpanded)

                            if !movie.description.isEmpty {
                                Button(isDescriptionExpanded ? "Daha az göster" : "Devamını oku") {
                                    isDescriptionExpanded.toggle()
                                }
                                .font(.subheadline.weight(.semibold))
                            }
                        }

                        HStack {
                            Text("Adet")
                            Spacer()
                            QuantityStepper(value: $quantity, range: 1...99)
                        }
                        .font(.headline)

                        Button {
                            Task { await cartVM.add(movie: movie, amount: quantity) }
                        } label: {
                            HStack {
                                Image(systemName: "cart.badge.plus")
                                Text("Sepete Ekle  •  Toplam \(AppTheme.price(movie.price * quantity))")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(AppTheme.primary)
                        .controlSize(.large)
                        .padding(.top, 8)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(uiColor: .systemBackground))
                            .shadow(color: .black.opacity(0.25), radius: 10, y: 6)
                    )
                    .padding(.horizontal, 16)

                    Color.clear.frame(height: 20)
                }
            }
        }
        .navigationTitle("Detay")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button { dismiss() } label: { Image(systemName: "chevron.left") }
            }
        }
    }
}
