import SwiftUI

struct SectionHeader: View {
    let title: String
    var onSeeAll: (() -> Void)? = nil
    var body: some View {
        HStack {
            Text(title).font(.title3).fontWeight(.semibold)
            Spacer()
            if onSeeAll != nil {
                Button("Tümü") { onSeeAll?() }
                    .font(.subheadline.weight(.semibold))
                    .tint(AppColors.getirPurple)
            }
        }
        .padding(.horizontal, 4)
    }
}
