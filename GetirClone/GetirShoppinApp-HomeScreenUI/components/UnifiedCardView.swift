import SwiftUI

enum CardKind { case product, category }
enum CardSize { case small, medium, large }

struct UnifiedCardView: View {
    let model: UnifiedCardModel
    let kind: CardKind
    var size: CardSize = .medium
    var showsAddButton: Bool = false
    var fixedWidth: CGFloat? = nil
    var categoryLabelsBelow: Bool = false
    
    private var productImageHeight: CGFloat {
        switch size { case .small: 110; case .medium: 130; case .large: 150 }
    }
    private let categoryCorner: CGFloat = 22
    
    var body: some View { content.frame(width: fixedWidth) }
    
    @ViewBuilder
    private var content: some View {
        if kind == .product { productCard }
        else if categoryLabelsBelow { categoryBelowCard }
        else { categoryInsideCard }
    }
    
    private var productCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .bottomTrailing) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.white)
                    if let n = model.imageName, !n.isEmpty, UIImage(named: n) != nil {
                        Image(n).resizable().scaledToFit().padding(4)
                    } else {
                        Image(systemName: "photo").imageScale(.large).foregroundStyle(.secondary)
                    }
                }
                .frame(height: productImageHeight)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                
                if showsAddButton {
                    Button(action: {}) {
                        Image(systemName: "plus")
                            .font(.title2.weight(.bold))
                            .frame(width: 44, height: 44)
                            .background(AppColors.getirPurple)
                            .foregroundStyle(.white)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.18), radius: 8, y: 4)
                    }
                    .padding(8)
                }
            }
            
            Text(model.title)
                .font(.subheadline.weight(.semibold))
                .lineLimit(2)
            
            if let s = model.subtitle, !s.isEmpty {
                Text(s).font(.caption).foregroundStyle(.secondary).lineLimit(1)
            }
            
            if let price = model.price {
                if let old = model.oldPrice, !old.isEmpty {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(old).font(.caption2).foregroundStyle(.secondary)
                            .strikethrough(true, color: .secondary)
                        Text(price).font(.subheadline.weight(.bold))
                            .foregroundStyle(AppColors.getirPurple)
                        if let unit = model.unitText { Text(unit).font(.caption2).foregroundStyle(.secondary) }
                    }
                } else {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(price).font(.subheadline.weight(.bold))
                            .foregroundStyle(AppColors.getirPurple)
                        if let unit = model.unitText { Text(unit).font(.caption2).foregroundStyle(.secondary) }
                    }
                }
            }
        }
        .padding(12)
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.10), radius: 10, y: 4)
    }
    private var categoryBelowCard: some View {
        VStack(spacing: 6) {
            ZStack {
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.12), radius: 8, y: 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                            .stroke(Color.black.opacity(0.04), lineWidth: 0.5)
                    )
                
                if let n = model.imageName, !n.isEmpty, UIImage(named: n) != nil {
                    Image(n)
                        .resizable()
                        .scaledToFill()
                        .scaleEffect(1.06)
                        .clipped()
                        .padding(2)
                } else {
                    Image(systemName: "photo").imageScale(.large).foregroundStyle(.secondary)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
            .aspectRatio(1, contentMode: .fit)
            
            Text(model.title)
                .font(.system(size: 13, weight: .semibold))
                .kerning(-0.2)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .multilineTextAlignment(.center)
        }
    }
    
    private var categoryInsideCard: some View {
        ZStack(alignment: .bottomTrailing) {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(model.title)
                        .font(.system(size: 16, weight: .semibold))
                        .lineLimit(2)
                        .minimumScaleFactor(0.9)
                    Spacer(minLength: 0)
                }
                .padding(.vertical, 14)
                .padding(.leading, 14)
                .padding(.trailing, 8)
                Spacer(minLength: 0)
            }
            
            if let n = model.imageName, !n.isEmpty, UIImage(named: n) != nil {
                Image(n)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 82)
                    .padding(.trailing, 10)
                    .padding(.bottom, 10)
            }
        }
        .frame(height: 130)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.10), radius: 10, y: 4)
    }
}
