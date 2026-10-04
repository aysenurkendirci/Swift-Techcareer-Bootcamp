//
//  Movie.swift
//  TechCareerFinalProject
//
//  Created by Ayşe Nur Kendirci on 20.09.2025.
//

import Foundation

struct Movie: Identifiable, Codable, Hashable {
    let id: Int
    let name: String
    let image: String
    let price: Int
    let category: String
    let rating: Double
    let year: Int
    let director: String
    let description: String
}
