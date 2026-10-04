//
//  CategoryGrid.swift
//  GetirShoppinApp-HomeScreenUI
//
//  Created by Ayşe Nur Kendirci on 14.09.2025.
//
import SwiftUI

struct CategoryGridSection: View {
    let chips: [CategoryChip]
    private let cols = [GridItem(.flexible(), spacing: 12),
                        GridItem(.flexible(), spacing: 12)]
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Kategoriler")
            LazyVGrid(columns: cols, spacing: 12) {
                ForEach(chips) { chip in
                    UnifiedCardView(model: .from(category: chip),
                                    kind: .category,
                                    size: .medium)
                }
            }
        }
    }
}
