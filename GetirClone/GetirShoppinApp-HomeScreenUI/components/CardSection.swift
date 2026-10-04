import SwiftUI

enum CardLayout { case grid(columns: Int), carousel(width: CGFloat) }

struct CardSection: View {
    let title: String
    let models: [UnifiedCardModel]
    let kind: CardKind
    var size: CardSize = .medium
    var layout: CardLayout
    var showsAddButton: Bool = false
    var onSeeAll: (() -> Void)? = nil
    var categoryLabelsBelow: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            SectionHeader(title: title, onSeeAll: onSeeAll)

            switch layout {
            case .grid(let cols):
                let isCategory = (kind == .category)
                let hSpacing: CGFloat = isCategory ? 10 : 12
                let vSpacing: CGFloat = isCategory ? 18 : 12
                let columns = Array(repeating: GridItem(.flexible(), spacing: hSpacing), count: cols)

                LazyVGrid(columns: columns, spacing: vSpacing) {
                    ForEach(models) { m in
                        UnifiedCardView(
                            model: m,
                            kind: kind,
                            size: size,
                            showsAddButton: showsAddButton,
                            categoryLabelsBelow: isCategory
                        )
                    }
                }
            case .carousel(let width):
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(models) { m in
                            UnifiedCardView(
                                model: m, kind: kind, size: size,
                                showsAddButton: showsAddButton, fixedWidth: width
                            )
                        }
                    }
                    .padding(.horizontal, 2)
                }
            }
        }
    }
}



