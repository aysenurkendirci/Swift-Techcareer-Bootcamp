//
//  PrimaryButton.swift
//  TechCareerFinalProject
//
//  Created by Ayşe Nur Kendirci on 20.09.2025.
//
import Foundation
import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .font(.headline)
                .contentShape(Rectangle())
                .accessibilityLabel(Text(title))
        }
        .buttonStyle(.borderedProminent)
        .tint(AppTheme.primary)
        .controlSize(.large)             
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
