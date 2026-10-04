import SwiftUI

struct SearchBarView: View {
    var body: some View {
        HStack(spacing: 10) {
            if UIImage(named: "magnifying-glass") != nil {
                Image("magnifying-glass").resizable().scaledToFit().frame(width: 18, height: 18)
            } else {
                Image(systemName: "magnifyingglass")
            }
            Text("Ürün Ara")
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)

            if UIImage(named: "mic") != nil {
                Image("mic").resizable().scaledToFit().frame(width: 18, height: 18)
            } else {
                Image(systemName: "mic.fill")
            }
        }
        .foregroundStyle(.secondary)
        .padding(14)
        .frame(height: 54)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.06), radius: 10, y: 2)
    }
}
