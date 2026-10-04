//
//  Header.swift
//  GetirShoppinApp-HomeScreenUI
//
//  Created by Ayşe Nur Kendirci on 14.09.2025.
//

import Foundation
import SwiftUI

struct SectionHeader: View {
    let title: String
    var onSeeAll: (() -> Void)? = nil
    var body: some View {
        HStack {
            Text(title).font(.title3).fontWeight(.semibold)
            Spacer()
            Button("Tümü") { onSeeAll?() }
                .font(.subheadline.weight(.semibold))
        }
        .padding(.horizontal, 4)
    }
}
