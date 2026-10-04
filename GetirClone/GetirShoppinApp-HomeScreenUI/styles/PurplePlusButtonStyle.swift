/*//
//  PurplePlusButtonStyle.swift
//  GetirShoppinApp-HomeScreenUI
//
//  Created by Ayşe Nur Kendirci on 14.09.2025.
//

import Foundation
import SwiftUI

struct PurplePlusButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline.weight(.bold))
            .padding(10)
            .background(AppColors.getirPurple)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .black.opacity(configuration.isPressed ? 0.02 : 0.08),
                    radius: configuration.isPressed ? 1 : 6, y: 3)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
 }*/
