//
//  ProductCardView.swift
//  GetirShoppinApp-HomeScreenUI
//
//  Created by Ayşe Nur Kendirci on 14.09.2025.
//

import Foundation
import SwiftUI

struct ProductCardView: View {
    let model: ProductUI
    var showsAddButton: Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                if let name = model.imageName, UIImage(named: name) != nil {
                    Image(name).resizable().scaledToFill()
                } else {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray.opacity(0.15))
                        .overlay(Image(systemName: "photo")
                                  .imageScale(.large).foregroundStyle(.secondary))
                }
            }
            .frame(height: 110)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(alignment: .topTrailing) {
                if showsAddButton {
                    Button { /* add to cart (UI) */ } label: {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(PurplePlusButtonStyle())
                    .padding(8)
                }
            }

            Text(model.title)
                .font(.subheadline).fontWeight(.semibold)
                .lineLimit(2)

            if let sub = model.subtitle {
                Text(sub).font(.caption).foregroundStyle(.secondary).lineLimit(1)
            }

            if let old = model.oldPrice, !old.isEmpty {
                VStack(alignment: .leading, spacing: 2) {
                    Text(old).font(.caption2)
                        .foregroundStyle(.secondary)
                        .strikethrough(true, color: .secondary)
                    Text(model.price)
                        .font(.subheadline).fontWeight(.bold)
                        .foregroundStyle(AppColors.getirPurple)
                    if let unit = model.unitText {
                        Text(unit).font(.caption2).foregroundStyle(.secondary)
                    }
                }
            } else {
                VStack(alignment: .leading, spacing: 2) {
                    Text(model.price).font(.subheadline).fontWeight(.bold)
                    if let unit = model.unitText {
                        Text(unit).font(.caption2).foregroundStyle(.secondary)
                    }
                }
            }
        }
        .padding(12)
        .frame(width: 180)
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.06), radius: 8, y: 4)
    }
}
