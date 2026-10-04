import SwiftUI

struct HomeScreen: View {

    private let chips: [CategoryChip] = [
        .init(title: "Yaza Özel", imageName: "category1", count: 12),
        .init(title: "İndirimler", imageName: "category2", count: 34),
        .init(title: "Bana Özel", imageName: "category3", count: 8),
        .init(title: "Su & İçecek", imageName: "category4", count: 1037),
        .init(title: "Meyve & Sebze", imageName: "category5", count: 162),
        .init(title: "Fırından", imageName: "category6", count: 157),
        .init(title: "Temel Gıda", imageName: "category7", count: 672),
        .init(title: "Atıştırmalık", imageName: "category8", count: 1194),
        .init(title: "Dondurma", imageName: "category9", count: 146),
        .init(title: "Süt Ürünleri", imageName: "category10", count: 661),
        .init(title: "Kahvaltılık", imageName: "category11", count: 367),
        .init(title: "Yiyecek", imageName: "category12", count: 116),
        .init(title: "Fit & Form", imageName: "category13", count: 283),
        .init(title: "Kişisel Bakım", imageName: "category14", count: 694),
        .init(title: "Bebek", imageName: "category15", count: 198),
        .init(title: "Ev & Yaşam", imageName: "category16", count: 130),
        .init(title: "Ev Bakım", imageName: "category17", count: 633),
        .init(title: "Cinsel Sağlık", imageName: "category18", count: 34),
        .init(title: "Evcil Hayvan", imageName: "category19", count: 104),
        .init(title: "Teknoloji", imageName: "category20", count: 75)
    ]

    private let noonDeals: [ProductUI] = [
        .init(title: "Erpiliç Piliç Göğüs Sote", subtitle: "kg",
              imageName: "slider2", price: "₺295,50", oldPrice: nil, unitText: "kg"),
        .init(title: "İçim %18 Yağlı Krema", subtitle: "200 ml",
              imageName: "slider3", price: "₺44,50", oldPrice: nil, unitText: "200 ml")
    ]

    private let pickedForYou: [ProductUI] = [
        .init(title: "Çilekli Danish Çörek", subtitle: "2 x 80 g",
              imageName: "slider4", price: "₺80,50", oldPrice: "₺89,00", unitText: nil),
        .init(title: "Magnum Classic", subtitle: "3 x 100 ml",
              imageName: "slider5", price: "₺171,99", oldPrice: "₺193,50", unitText: nil)
    ]

    private var categoryModels: [UnifiedCardModel] { chips.map(UnifiedCardModel.from) }
    private var noonModels:     [UnifiedCardModel] { noonDeals.map(UnifiedCardModel.from) }
    private var pickedModels:   [UnifiedCardModel] { pickedForYou.map(UnifiedCardModel.from) }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                HeaderSection()

                VStack(spacing: 18) {
                    HeroBannerSection()
                        .padding(.horizontal, 16)
                        .indexViewStyle(.page(backgroundDisplayMode: .always))

                    SearchBarView()
                        .padding(.horizontal, 16)

                    CardSection(
                        title: "Kategoriler",
                        models: categoryModels,
                        kind: .category,
                        size: .small,
                        layout: .grid(columns: 3),
                        onSeeAll: {}
                    )
                    .padding(.horizontal, 16)

                    CardSection(
                        title: "Gün Ortası Önerileri 😊",
                        models: noonModels,
                        kind: .product,
                        size: .medium,
                        layout: .carousel(width: 240),
                        showsAddButton: true
                    )
                    .padding(.horizontal, 16)

                    CardSection(
                        title: "Sana Seçtiğimiz Paketler ⭐",
                        models: pickedModels,
                        kind: .product,
                        size: .medium,
                        layout: .carousel(width: 240),
                        showsAddButton: true
                    )
                    .padding(.horizontal, 16)

                    Spacer(minLength: 24)
                }
                .padding(.top, 8)
                .background(AppColors.pageBackground)
            }
        }
        .background(AppColors.pageBackground)
        .navigationBarHidden(true)
    }
}
