//
//  MoviesScreen.swift
//  TechCareerFinalProject
//
//  Created by Ayşe Nur Kendirci on 20.09.2025.
//

import SwiftUI

struct MoviesScreen: View {
    
    @EnvironmentObject var cartVM: CartViewModel
    @StateObject private var vm = MoviesViewModel()
    @State private var searchText = ""

    private let gridColumns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        ZStack(alignment: .bottomTrailing) {

            LinearGradient(colors: [Color.black, Color.black.opacity(0.92)],
                           startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 16) {

                    HStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.secondary)
                        TextField("Film ara", text: $searchText)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                    }
                    .padding(12)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal, 16)
                    .onChange(of: searchText) { _, q in vm.applySearch(q) }

                    LazyVGrid(columns: gridColumns, spacing: 16) {
                        ForEach(vm.visibleMovies) { movie in
                            VStack(alignment: .leading, spacing: 10) {

                                NavigationLink(value: movie) {
                                    ZStack(alignment: .topLeading) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 14).fill(.ultraThinMaterial)
                                            AsyncImage(url: MoviesRepository.imageURL(for: movie.image)) { phase in
                                                switch phase {
                                                case .empty:
                                                    ProgressView().scaleEffect(0.9)
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
                                        }
                                        .aspectRatio(2/3, contentMode: .fit)
                                        .clipShape(RoundedRectangle(cornerRadius: 14))

                                        if movie.price % 5 == 0 {
                                            Text("-20%")
                                                .font(.caption.weight(.semibold))
                                                .padding(.horizontal, 10)
                                                .padding(.vertical, 6)
                                                .background(.red, in: Capsule())
                                                .foregroundStyle(.white)
                                                .padding(8)
                                        }
                                        VStack {
                                            Spacer()
                                            HStack {
                                                RatingBadge(value: movie.rating)
                                                Spacer()
                                                Text(AppTheme.price(movie.price))
                                                    .font(.caption.weight(.semibold))
                                                    .padding(.horizontal, 10)
                                                    .padding(.vertical, 6)
                                                    .background(.ultraThinMaterial, in: Capsule())
                                            }
                                            .padding(8)
                                        }
                                    }
                                }
                                .buttonStyle(.plain)

                                HStack(alignment: .center) {
                                    Text(movie.name)
                                        .font(.subheadline.weight(.semibold))
                                        .foregroundStyle(.primary)
                                        .lineLimit(2)
                                        .frame(maxWidth: .infinity, alignment: .leading)

                                    Button {
                                        Task { await cartVM.add(movie: movie, amount: 1) }
                                    } label: {
                                        Image(systemName: "cart.badge.plus").imageScale(.medium)
                                    }
                                    .buttonStyle(.bordered)
                                    .tint(AppTheme.primary)
                                    .contentShape(Rectangle())
                                    .allowsHitTesting(true)
                                }
                                .padding(.horizontal, 6)
                                .padding(.bottom, 6)
                                .padding(.top, 2)
                            }
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(uiColor: .systemBackground))
                                    .shadow(color: .black.opacity(0.25), radius: 8, y: 4)
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                    Color.clear.frame(height: 100)
                }
                .padding(.top, 8)
            }

            NavigationLink { CartScreen() } label: {
                ZStack {
                    Circle()
                        .fill(AppTheme.primary)
                        .frame(width: 58, height: 58)
                        .shadow(color: .black.opacity(0.35), radius: 10, y: 6)
                    Image(systemName: "cart.fill")
                        .foregroundStyle(.white)
                        .imageScale(.large)
                }
            }
            .padding(.trailing, 18)
            .padding(.bottom, 18)
            .zIndex(2)
            .contentShape(Rectangle())
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .navigationBar)
        .task { await vm.loadMovies() }
    }
}
