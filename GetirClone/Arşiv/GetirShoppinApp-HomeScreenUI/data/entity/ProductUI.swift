//
//  ProductUI.swift
//  GetirShoppinApp-HomeScreenUI
//
//  Created by Ayşe Nur Kendirci on 14.09.2025.
//

import Foundation
struct ProductUI: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String?
    let imageName: String?
    let price: String
    let oldPrice: String?
    let unitText: String?
}
