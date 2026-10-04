import SwiftUI
struct HeroBannerSection: View {
    private let banners = ["banner-1", "banner-2", "banner-3"]

    var body: some View {
        TabView {
            ForEach(banners, id: \.self) { name in
                if UIImage(named: name) != nil {
                    Image(name)
                        .resizable()
                        .renderingMode(.original)
                        .scaledToFill()
                        .frame(height: 176)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                } else {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.gray.opacity(0.12))
                        .overlay(Image(systemName: "photo").imageScale(.large).foregroundStyle(.secondary))
                        .frame(height: 176)
                }
            }
        }
        .frame(height: 176)
        .tabViewStyle(.page(indexDisplayMode: .always))
        .padding(.horizontal, 16)
        .padding(.top, 8)                 
    }
}
