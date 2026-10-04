//
//  UnifiedCard.swift
//  GetirShoppinApp-HomeScreenUI
//
//  Created by Ayşe Nur Kendirci on 14.09.2025.
//

// data/entity/UnifiedCardModel.swift (veya modeli nereye koyduysan)

// UnifiedCardModel+Map.swift
import Foundation

struct UnifiedCardModel: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String?
    let imageName: String?
    let price: String?
    let oldPrice: String?
    let unitText: String?
}

// küçük yardımcı: "(...)" değilse sar
private func paren(_ s: String) -> String {
    let t = s.trimmingCharacters(in: .whitespacesAndNewlines)
    if t.hasPrefix("(") && t.hasSuffix(")") { return t }
    return "(\(t))"
}

extension UnifiedCardModel {
    static func from(_ p: ProductUI) -> Self {
        .init(title: p.title,
              subtitle: p.subtitle,
              imageName: p.imageName,
              price: p.price,
              oldPrice: p.oldPrice,
              unitText: p.unitText)
    }

    static func from(_ c: CategoryChip) -> Self {
        .init(title: c.title,
              subtitle: c.count.map { paren(String($0)) }, // ⬅️ tek parantez
              imageName: c.imageName,
              price: nil, oldPrice: nil, unitText: nil)
    }
}
