//
//  CategoryGridSection.swift
//  GetirShoppinApp-HomeScreenUI
//
//  Created by Ayşe Nur Kendirci on 14.09.2025.
//

import SwiftUI

struct CategoryGridSection: View {
    let chips: [CategoryChip]
    var onSeeAll: (() -> Void)? = nil

    private let hPadding: CGFloat = 16
    private let spacing: CGFloat  = 12

    private var tileWidth: CGFloat {
        let screen = UIScreen.main.bounds.width
        return (screen - (hPadding * 2) - (spacing * 2)) / 3
    }
    private var columns: [GridItem] {
        Array(repeating: GridItem(.fixed(tileWidth), spacing: spacing), count: 3)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Kategoriler", onSeeAll: onSeeAll)

            LazyVGrid(columns: columns, alignment: .center, spacing: spacing) {
                ForEach(chips) { chip in
                    UnifiedCardView(
                        model: .from(chip),
                        kind: .category,
                        size: .small,
                        fixedWidth: tileWidth
                    )
                }
            }
        }
    }
}
