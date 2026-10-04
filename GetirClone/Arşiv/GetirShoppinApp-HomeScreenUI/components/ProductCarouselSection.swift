//
//  ProductCarouselSection.swift
//  GetirShoppinApp-HomeScreenUI
//
//  Created by Ayşe Nur Kendirci on 14.09.2025.
//

import SwiftUI

struct ProductCarouselSection: View {
    let title: String
    let items: [ProductUI]
    var showsAddButton: Bool = true
    var onSeeAll: (() -> Void)? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            SectionHeader(title: title, onSeeAll: onSeeAll)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(items) { item in
                        UnifiedCardView(
                            model: .from(item),
                            kind: .product,
                            size: .medium,
                            showsAddButton: showsAddButton,
                            fixedWidth: 240
                        )
                    }
                }
                .padding(.horizontal, 2)
            }
        }
    }
}
