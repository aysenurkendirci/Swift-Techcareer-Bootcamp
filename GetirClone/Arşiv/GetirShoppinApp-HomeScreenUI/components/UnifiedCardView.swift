//
//  UnifiedCardView.swift
//  GetirShoppinApp-HomeScreenUI
//
//  Created by Ayşe Nur Kendirci on 14.09.2025.
//
// UnifiedCardView.swift
import SwiftUI

enum CardKind { case product, category }
enum CardSize { case small, medium, large }

struct UnifiedCardView: View {
    let model: UnifiedCardModel
    let kind: CardKind
    var size: CardSize = .medium
    var showsAddButton: Bool = false
    var fixedWidth: CGFloat? = nil

    private var productImageHeight: CGFloat {
        switch size { case .small: 90; case .medium: 110; case .large: 140 }
    }
    private var categoryImageHeight: CGFloat {
        switch size { case .small: 64; case .medium: 76; case .large: 88 }
    }
    private var categoryHeight: CGFloat {
        switch size { case .small: 118; case .medium: 126; case .large: 138 }
    }

    var body: some View {
        Group { kind == .product ? AnyView(productBody) : AnyView(categoryBody) }
            .frame(width: fixedWidth)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: .black.opacity(0.06), radius: 10, y: 4)
    }

    // PRODUCT
    private var productBody: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                if let n = model.imageName, !n.isEmpty, UIImage(named: n) != nil {
                    Image(n).resizable().scaledToFill()
                } else {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray.opacity(0.12))
                        .overlay(Image(systemName: "photo").imageScale(.large).foregroundStyle(.secondary))
                }

                if showsAddButton {
                    Image(systemName: "plus")
                        .font(.headline.weight(.bold))
                        .padding(10)
                        .background(AppColors.getirPurple)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(8)
                }
            }
            .frame(height: productImageHeight)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

            Text(model.title).font(.subheadline.weight(.semibold)).lineLimit(2)

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
                        if let unit = model.unitText {
                            Text(unit).font(.caption2).foregroundStyle(.secondary)
                        }
                    }
                } else {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(price).font(.subheadline.weight(.bold))
                        if let unit = model.unitText {
                            Text(unit).font(.caption2).foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
        .padding(12)
    }

    // CATEGORY
    private var categoryBody: some View {
        ZStack(alignment: .bottomTrailing) {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: size == .small ? 4 : 6) {
                    Text(model.title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.primary)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                        .minimumScaleFactor(0.9)
                    if let s = model.subtitle, !s.isEmpty {
                        Text(s).font(.footnote).foregroundStyle(.secondary).lineLimit(1)
                    }
                    Spacer(minLength: 0)
                }
                .padding(.vertical, size == .small ? 12 : 14)
                .padding(.leading, 14)
                .padding(.trailing, 8)
                Spacer(minLength: 0)
            }

            if let n = model.imageName, !n.isEmpty, UIImage(named: n) != nil {
                Image(n)
                    .resizable()
                    .scaledToFit()
                    .frame(height: categoryImageHeight)
                    .padding(.trailing, 10)
                    .padding(.bottom, 10)
            }
        }
        .frame(height: categoryHeight)
    }
}
