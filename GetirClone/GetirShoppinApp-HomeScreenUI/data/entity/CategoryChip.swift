import Foundation

struct CategoryChip: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let count: Int?
}
