import Foundation
import SwiftUI

@MainActor
final class CartViewModel: ObservableObject {

    @Published private(set) var cartItems: [CartItem] = []
    @Published var query: String = ""
    @Published private(set) var isLoading: Bool = false
    @Published var errorText: String?

    var userName: String {
        get { UserDefaults.standard.string(forKey: "movie_user") ?? "aysenur_18" }
        set { UserDefaults.standard.set(newValue, forKey: "movie_user") }
    }

    private let repo: MoviesRepo
    init(repo: MoviesRepo = MoviesRepository()) { self.repo = repo }

 
    var filteredItems: [CartItem] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return cartItems } //arama boşsa tüm liste
        let lower = trimmed.lowercased()
        return cartItems.filter { $0.name.lowercased().contains(lower) }
    }

    var groups: [CartGroup] {
        var dict: [String: CartGroup] = [:]
        for item in cartItems {
            let groupKey = makeGroupKey(for: item)
            if var group = dict[groupKey] {
                group.qty += item.orderAmount
                dict[groupKey] = group
            } else {
                dict[groupKey] = CartGroup(
                    id: groupKey,
                    name: item.name,
                    image: item.image,
                    unitPrice: item.price,
                    qty: item.orderAmount
                )
            }
        }
        return Array(dict.values).sorted { $0.name < $1.name }
    }

    var filteredGroups: [CartGroup] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return groups }
        let lower = trimmed.lowercased()
        return groups.filter { $0.name.lowercased().contains(lower) }
    }

    var total: Int {
        groups.reduce(0) { $0 + $1.total }
    }

    struct CartGroup: Identifiable, Hashable {
        let id: String
        let name: String
        let image: String
        let unitPrice: Int
        var qty: Int
        var total: Int { unitPrice * qty }
    }

    private func makeGroupKey(for item: CartItem) -> String { //aynı film aynı anahtar
        "\(item.name)|\(item.image)|\(item.price)"
    }

   
    func refresh() async {
        isLoading = true
        defer { isLoading = false }
        do {
            let rows = try await repo.fetchCart(userName: userName)
            self.cartItems = rows
            self.errorText = nil
        } catch {
            self.errorText = "Sepet boş,ürün ekleyeniz."
            self.cartItems = []
        }
    }

    func add(movie: Movie, amount: Int) async {
        let phantom = CartItem(
            cartId: Int.random(in: 1...Int.max),
            name: movie.name,
            image: movie.image,
            price: movie.price,
            category: movie.category,
            rating: movie.rating,
            year: movie.year,
            director: movie.director,
            description: movie.description,
            orderAmount: amount,
            userName: userName
        )
        cartItems.append(phantom)

       
        do {
            try await repo.add(movie: movie, amount: amount, userName: userName)
            await refresh()
        } catch {
            cartItems.removeAll { $0.cartId == phantom.cartId }
            errorText = "Sepete eklenemedi."
        }
    }
//tekli ürün silme
    func decrementOne(from group: CartGroup) async {
        if let row = cartItems.first(where: { makeGroupKey(for: $0) == group.id }) {
            do {
                try await repo.remove(cartId: row.cartId, userName: userName)
                await refresh()
            } catch {
                errorText = "Silinemedi."
            }
        }
    }
//toplu silme
    func removeAll(in group: CartGroup) async {
        let toDelete = cartItems.filter { makeGroupKey(for: $0) == group.id }
        guard !toDelete.isEmpty else { return }
        do {
            for row in toDelete {
                try await repo.remove(cartId: row.cartId, userName: userName)
            }
            await refresh()
        } catch {
            errorText = "Toplu silme başarısız."
        }
    }

    func applySearch(_ text: String) {
        query = text
    }
}
