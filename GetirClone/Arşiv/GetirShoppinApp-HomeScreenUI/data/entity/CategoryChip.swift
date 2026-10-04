//
//  CategoryChip.swift
//  GetirShoppinApp-HomeScreenUI
//
//  Created by Ayşe Nur Kendirci on 14.09.2025.
//

import Foundation
struct CategoryChip: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let count: Int?
}
