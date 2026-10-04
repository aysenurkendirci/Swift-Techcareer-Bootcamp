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

private func paren(_ s: String) -> String {
    let t = s.trimmingCharacters(in: .whitespacesAndNewlines)
    if t.hasPrefix("("), t.hasSuffix(")") { return t }
    return "(\(t))"
}

extension UnifiedCardModel {
    static func from(_ p: ProductUI) -> Self {
        .init(title: p.title, subtitle: p.subtitle, imageName: p.imageName,
              price: p.price, oldPrice: p.oldPrice, unitText: p.unitText)
    }
    static func from(_ c: CategoryChip) -> Self {
        .init(title: c.title,
              subtitle: c.count.map { paren(String($0)) },
              imageName: c.imageName, price: nil, oldPrice: nil, unitText: nil)
    }
}

