import SwiftUI

struct AddressRowView: View {
    var body: some View {
        HStack(spacing: 12) {
            HStack(spacing: 6) {
                Image("home")            // Assets: "home" varsa
                    .resizable().scaledToFit().frame(width: 16, height: 16)
                Text("Ev, Cevizli, Kır Sk. 13 A, 34846 Maltepe…")
                    .font(.subheadline).fontWeight(.semibold)
                    .lineLimit(1)
            }
            .padding(.horizontal, 10).padding(.vertical, 8)
            .background(AppColors.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            HStack(spacing: 6) {
                Text("TVS").font(.caption).fontWeight(.bold)
                Text("45–60 dk").font(.caption).fontWeight(.semibold)
            }
            .padding(.horizontal, 10).padding(.vertical, 8)
            .background(AppColors.getirYellow)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding(.horizontal, 16)
        .offset(y: -20)   // mor şeritten aşağı “taşma” efekti
    }
}
