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
