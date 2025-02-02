//
//  FavoritesUseCasesTests.swift
//  InstantNewsTests
//
//  Created by Lucas on 02/02/2025.
//

import Testing
@testable import InstantNews

struct FavoritesUseCasesTests {
    let favoritesUseCases = FavoritesUseCasesImpl()

    @Test func testAddToFavorites() async throws {
        let news = News(source: InstantNews.Source(id: nil, name: ""), author: nil, title: "Test News", description: "", url: "", urlToImage: "", publishedAt: "", content: "", newsType: .science)
        try await favoritesUseCases.saveToFavorites(news: news)

        let favorites = try await favoritesUseCases.getFavorites()
        await Task.sleep(UInt64(0.5 * 1_000_000_000))

        #expect(favorites.contains(where: { $0.title == "Test News" }))
    }

    @Test func testRemoveFromFavorites() async throws {
        let news = News(source: InstantNews.Source(id: nil, name: ""), author: nil, title: "Test News", description: "", url: "", urlToImage: "", publishedAt: "", content: "", newsType: .science)
        try await favoritesUseCases.saveToFavorites(news: news)
        try await favoritesUseCases.removeFromFavorites(news: news)

        let favorites = try await favoritesUseCases.getFavorites()
        await Task.sleep(UInt64(0.5 * 1_000_000_000))
        #expect(!favorites.contains(where: { $0.title == "Test News" }))
    }
}
