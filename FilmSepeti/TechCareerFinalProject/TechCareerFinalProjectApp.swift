//
//  TechCareerFinalProjectApp.swift
//  TechCareerFinalProject
//
//  Created by Ayşe Nur Kendirci on 19.09.2025.
//
import SwiftUI

@main
struct TechCareerFinalProjectApp: App {
    private let repo = MoviesRepository()

    @StateObject private var moviesVM = MoviesViewModel(repo: MoviesRepository())
    @StateObject private var cartVM   = CartViewModel(repo: MoviesRepository())

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(moviesVM)
                .environmentObject(cartVM)
        }
    }
}
