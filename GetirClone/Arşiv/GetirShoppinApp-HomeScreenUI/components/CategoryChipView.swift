//
//  CategoryChipView.swift
//  GetirShoppinApp-HomeScreenUI
//
//  Created by Ayşe Nur Kendirci on 14.09.2025.
//

import Foundation
import SwiftUI

struct CategoryChipView: View {
    let chip: CategoryChip
    var body: some View {
        HStack(spacing: 10) {
            // Görsel (assets’ten)
            Image(chip.imageName)
                .resizable().scaledToFit()
                .frame(width: 54, height: 54)
                .padding(8)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 2) {
                Text(chip.title).font(.subheadline).fontWeight(.semibold)
                if let c = chip.count {
                    Text("\(c)").font(.caption2).foregroundStyle(.secondary)
                }
            }
            Spacer(minLength: 0)
        }
        .padding(12)
        .frame(width: 220)
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.06), radius: 8, y: 4)
    }
}
