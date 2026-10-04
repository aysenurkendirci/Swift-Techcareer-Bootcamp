//
//  RatingBadge.swift
//  TechCareerFinalProject
//
//  Created by Ayşe Nur Kendirci on 20.09.2025.
//
import SwiftUI

struct RatingBadge: View {
    let value: Double
    @State private var isPopping = false

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "star.fill")
                .imageScale(.small)
                .foregroundStyle(.yellow)

            Text(String(format: "%.1f", value))
                .font(.caption.weight(.semibold))
                .monospacedDigit()
                .accessibilityLabel(Text("Puan \(String(format: "%.1f", value))"))
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(.ultraThinMaterial, in: Capsule())
        .scaleEffect(isPopping ? 1 : 0.9)
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                isPopping = true
            }
        }
    }
}

struct PriceBadge: View {
    let price: Int

    var body: some View {
        Text(AppTheme.price(price))
            .font(.caption.weight(.semibold))
            .monospacedDigit()
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(.ultraThinMaterial, in: Capsule())
            .accessibilityLabel(Text("Fiyat \(AppTheme.price(price))"))
    }
}
