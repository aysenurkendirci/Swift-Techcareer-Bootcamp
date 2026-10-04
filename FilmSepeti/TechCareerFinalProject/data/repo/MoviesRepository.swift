//
//  MoviesRepository.swift
//  TechCareerFinalProject
//
//  Created by Ayşe Nur Kendirci on 20.09.2025.
//

import Foundation

enum APIPaths {
    static let base   = "http://kasimadalan.pe.hu/movies"
    static let list   = base + "/getAllMovies.php"
    static let cart   = base + "/getMovieCart.php"
    static let insert = base + "/insertMovie.php"
    static let delete = base + "/deleteMovie.php"
    static let images = base + "/images/"
}

protocol MoviesRepo {
    func fetchMovies() async throws -> [Movie]
    func fetchCart(userName: String) async throws -> [CartItem]
    func add(movie: Movie, amount: Int, userName: String) async throws
    func remove(cartId: Int, userName: String) async throws
}

struct MoviesRepository: MoviesRepo {
    private static let decoder: JSONDecoder = {
        let d = JSONDecoder()
        return d
    }()

    private static let formContentType = "application/x-www-form-urlencoded; charset=utf-8"

    func fetchMovies() async throws -> [Movie] {
        guard let url = URL(string: APIPaths.list) else { throw URLError(.badURL) }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return try Self.decoder.decode(MovieListResponse.self, from: data).movies
    }

    func fetchCart(userName: String) async throws -> [CartItem] {
        guard let url = URL(string: APIPaths.cart) else { throw URLError(.badURL) }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.setValue(Self.formContentType, forHTTPHeaderField: "Content-Type")
        request.httpBody = Self.urlEncodedForm(["userName": userName])

        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return try Self.decoder.decode(CartListResponse.self, from: data).movie_cart ?? []
    }

    func add(movie: Movie, amount: Int, userName: String) async throws {
        let times = max(1, amount)
        for _ in 0..<times {
            try await postAdd(movie: movie, orderAmount: 1, userName: userName)
        }
    }

    func remove(cartId: Int, userName: String) async throws {
        guard let url = URL(string: APIPaths.delete) else { throw URLError(.badURL) }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(Self.formContentType, forHTTPHeaderField: "Content-Type")
        request.httpBody = Self.urlEncodedForm([
            "cartId": String(cartId),
            "userName": userName
        ])

        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        _ = try Self.decoder.decode(CRUDResponse.self, from: data)
    }

    static func imageURL(for filename: String) -> URL? {
        URL(string: APIPaths.images + filename)
    }

    private static func urlEncodedForm(_ params: [String: String]) -> Data? {
        let allowed = CharacterSet.urlQueryAllowed
        let bodyString = params.map { key, value in
            let k = key.addingPercentEncoding(withAllowedCharacters: allowed) ?? key
            let v = value.addingPercentEncoding(withAllowedCharacters: allowed) ?? value
            return "\(k)=\(v)"
        }
        .joined(separator: "&")
        return bodyString.data(using: .utf8)
    }

    // MARK: - Private helper
    private func postAdd(movie: Movie, orderAmount: Int, userName: String) async throws {
        guard let url = URL(string: APIPaths.insert) else { throw URLError(.badURL) }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(Self.formContentType, forHTTPHeaderField: "Content-Type")

        let params: [String: String] = [
            "name": movie.name,
            "image": movie.image,
            "price": String(movie.price),
            "category": movie.category,
            "rating": String(movie.rating),
            "year": String(movie.year),
            "director": movie.director,
            "description": movie.description,
            "orderAmount": String(orderAmount),
            "userName": userName
        ]
        request.httpBody = Self.urlEncodedForm(params)

        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        _ = try Self.decoder.decode(CRUDResponse.self, from: data)
    }
}
