//
//  FavoriteUseCases.swift
//  InstantNews
//
//  Created by Lucas on 01/02/2025.
//

import Foundation

protocol FavoritesUseCases {
    func saveToFavorites(news: News) async throws
    func removeFromFavorites(news: News) async throws
    func isFavorite(news: News) async throws -> Bool
    func getFavorites() async throws -> [News]
    func toggleFavorite(isFavorite: Bool, news: News) async throws
}

class FavoritesUseCasesImpl: FavoritesUseCases {
    private let userDefaultsKey = "favoriteNews"

    func getFavorites() async throws -> [News] {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else {
            return []
        }
        do {
            return try JSONDecoder().decode([News].self, from: data)
        } catch {
            print("❌ Error decoding favorites: \(error)")
            throw error
        }
    }

    private func saveFavorites(_ favorites: [News]) async throws {
        do {
            let encoded = try JSONEncoder().encode(favorites)
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        } catch {
            print("❌ Error encoding favorites: \(error)")
            throw error
        }
    }

    func saveToFavorites(news: News) async throws {
        var favorites = try await getFavorites()
        if !favorites.contains(where: { $0.url == news.url }) {
            favorites.append(news)
            try await saveFavorites(favorites)
        }
    }

    func removeFromFavorites(news: News) async throws {
        var favorites = try await getFavorites()
        favorites.removeAll { $0.url == news.url }
        try await saveFavorites(favorites)
    }

    func isFavorite(news: News) async -> Bool {
        do {
            let favorites = try await getFavorites()
            return favorites.contains { $0.url == news.url }
        } catch {
            return false
        }
    }

    func toggleFavorite(isFavorite: Bool, news: News) async throws {
        if isFavorite {
            try await removeFromFavorites(news: news)
        } else {
            try await removeFromFavorites(news: news)
        }
    }
}
