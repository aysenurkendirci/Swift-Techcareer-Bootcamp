//
//  CardSection.swift
//  GetirShoppinApp-HomeScreenUI
//
//  Created by Ayşe Nur Kendirci on 14.09.2025.
//
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

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            SectionHeader(title: title, onSeeAll: onSeeAll)
            switch layout {
            case .grid(let cols):
                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 12), count: cols),
                          spacing: 12) {
                    ForEach(models) { m in
                        UnifiedCardView(model: m, kind: kind, size: size)
                    }
                }
            case .carousel(let width):
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(models) { m in
                            UnifiedCardView(model: m, kind: kind, size: size,
                                            showsAddButton: showsAddButton, fixedWidth: width)
                        }
                    }
                    .padding(.horizontal, 2)
                }
            }
        }
    }
}
