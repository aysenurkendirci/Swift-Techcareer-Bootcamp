import SwiftUI

fileprivate func topInset() -> CGFloat {
    UIApplication.shared.connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .first?.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets.top ?? 0
}

struct HomeScreen: View {
    
    private let chips: [CategoryChip] = [
        .init(title: "Yaza Özel",     imageName: "category1",  count: nil),
        .init(title: "İndirimler",    imageName: "category2",  count: nil),
        .init(title: "Bana Özel",     imageName: "category3",  count: nil),
        .init(title: "Su&içecek",     imageName: "category4",  count: 1037),
        .init(title: "Meyve&Sebze",   imageName: "category5",  count: 162),
        .init(title: "Fırından",      imageName: "category6",  count: 157),
        .init(title: "Temel Gıda",    imageName: "category7",  count: 672),
        .init(title: "Atıştırmalık",  imageName: "category8",  count: 1194),
        .init(title: "Dondurma",      imageName: "category9",  count: 146),
        .init(title: "Süt Ürünleri",  imageName: "category10", count: 661),
        .init(title: "Kahvaltılık",   imageName: "category11", count: 367),
        .init(title: "Yiyecek",       imageName: "category12", count: 116),
        .init(title: "Fit & Form",    imageName: "category13", count: 283),
        .init(title: "Kişisel Bakım", imageName: "category14", count: 694),
        

        .init(title: "Ev Bakım",      imageName: "category15", count: 633),
        .init(title: "Ev & Yaşam",    imageName: "category16", count: 130),
        .init(title: "Teknoloji",     imageName: "category17", count: 75),
        .init(title: "Evcil Hayvan",  imageName: "category18", count: 104),
        .init(title: "Bebek",         imageName: "category19", count: 198),
        .init(title: "Cinsel Sağlık", imageName: "category20", count: 34)
    ]
    
    private var categoryModels: [UnifiedCardModel] { chips.map(UnifiedCardModel.from) }
    private var headerHeight: CGFloat {
        topInset() + 32 + 8 + 40
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 6) {
                    TabView {
                        ForEach(1...6, id: \.self) { i in
                            ZStack {
                                if UIImage(named: "slider\(i)") != nil {
                                    Image("slider\(i)")
                                        .resizable()
                                        .renderingMode(.original)
                                        .scaledToFill()
                                } else {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.gray.opacity(0.15))
                                        .overlay(Image(systemName: "photo")
                                            .imageScale(.large).foregroundStyle(.secondary))
                                }
                            }
                            .frame(height: 176)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .shadow(color: .black.opacity(0.10), radius: 10, y: 4)
                            .padding(.horizontal, 16)
                        }
                    }
                    .frame(height: 176)
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    
                    SearchBarView()
                        .padding(.horizontal, 16)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Kategoriler").font(.title3.weight(.semibold))
                            Spacer()
                            Button("Tümü") {}
                                .font(.subheadline.weight(.semibold))
                                .tint(AppColors.getirPurple)
                        }
                        .padding(.horizontal, 16)
                        
                        let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 4)
                        LazyVGrid(columns: columns, spacing: 18) {
                            ForEach(categoryModels) { m in
                                UnifiedCardView(
                                    model: m,
                                    kind: .category,
                                    size: .small,
                                    showsAddButton: false,
                                    fixedWidth: nil,
                                    categoryLabelsBelow: true
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 8)
                    }
                    
                    Spacer(minLength: 16)
                }
                .background(AppColors.pageBackground)
                .padding(.top, headerHeight)
            }
            .background(AppColors.pageBackground)
            .navigationBarHidden(true)
            
            HeaderSection()
                .frame(height: headerHeight, alignment: .top)
                .allowsHitTesting(true)
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    NavigationStack { HomeScreen() }
        .tint(AppColors.getirPurple)
}
