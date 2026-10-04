import SwiftUI

struct HeaderSection: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            AppColors.getirPurple
                .ignoresSafeArea(edges: .top)
                .frame(height: 140)

            VStack(spacing: 12) {
                if UIImage(named: "getirlogo") != nil {
                    Image("getirlogo")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 24)
                } else {
                    Text("getirbüyük")
                        .font(.title2).bold()
                        .foregroundStyle(AppColors.getirYellow)
                }

                HStack(spacing: 12) {
                    HStack(spacing: 6) {
                        if UIImage(named: "home") != nil {
                            Image("home").resizable().scaledToFit()
                                .frame(width: 16, height: 16)
                        }
                        Text("Ev, Cevizli, Kır Sk. 13 A, 34846 Maltepe…")
                            .font(.subheadline).fontWeight(.semibold)
                            .lineLimit(1)
                    }
                    .padding(.horizontal, 10).padding(.vertical, 8)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                    HStack(spacing: 6) {
                        Text("TVS").font(.caption).fontWeight(.bold)
                        Text("45–60 dk").font(.caption).fontWeight(.semibold)
                        Image(systemName: "chevron.down").font(.caption2)
                    }
                    .padding(.horizontal, 10).padding(.vertical, 8)
                    .background(AppColors.getirYellow)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
            }
            .padding(.top, 8)
        }
    }
}
