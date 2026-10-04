import Foundation
import SwiftUI

@MainActor
final class MoviesViewModel: ObservableObject {
    
    @Published var allMovies: [Movie] = []
    @Published var visibleMovies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorText: String?
    
    private let repo: MoviesRepo
    init(repo: MoviesRepo = MoviesRepository()) {
        self.repo = repo
    }
    
    func loadMovies() async {
        isLoading = true
        defer { isLoading = false }
        do {
            let movies = try await repo.fetchMovies()
            self.allMovies = movies
            self.visibleMovies = movies
            self.errorText = nil
        } catch {
            self.errorText = "Filmler yüklenirken sorun oluştu."
        }
    }
    //arama kutusu boşsa liste tam haline getirir
    func applySearch(_ text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            visibleMovies = allMovies
            return
        }
        let query = trimmed.lowercased() //
        visibleMovies = allMovies.filter { movie in
            movie.name.lowercased().contains(query) ||
            movie.category.lowercased().contains(query) ||
            movie.director.lowercased().contains(query)
        }
    }
}
