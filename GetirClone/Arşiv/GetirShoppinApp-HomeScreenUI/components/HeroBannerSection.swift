import SwiftUI

struct HeroBannerSection: View {
    private let banners = ["slider1", "slider2", "slider3", "slider4", "slider5", "slider6"]

    var body: some View {
        TabView {
            ForEach(banners, id: \.self) { name in
                Image(name)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 180)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
        }
        .frame(height: 180)
        .tabViewStyle(.page(indexDisplayMode: .always))
    }
}
