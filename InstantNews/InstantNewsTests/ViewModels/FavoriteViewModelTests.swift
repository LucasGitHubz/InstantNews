//
//  FavoriteViewModelTests.swift
//  InstantNewsTests
//
//  Created by Lucas on 02/02/2025.
//

import Testing
@testable import InstantNews
import Foundation

struct FavoriteViewModelTests {
    let favoritesUseCases = FavoritesUseCasesImpl()
    let viewModel: FavoriteViewModel

    init() async throws {
        self.viewModel = FavoriteViewModel(favoritesUseCases: favoritesUseCases)
        await clearFavorites()
    }

    @Test func testInitialState() async {
        #expect(viewModel.favoritesNews.isEmpty == true)
        #expect(viewModel.errorMessage.isEmpty == true)
        #expect(viewModel.showAlert == false)
    }

    @Test func testAddToFavorites() async throws {
        let news = News(source: InstantNews.Source(id: nil, name: ""), author: nil, title: "Test News", description: "", url: "3", urlToImage: "", publishedAt: "", content: "", newsType: .science)
        let favoriteNewsValue = viewModel.favoritesNews.count

        try await favoritesUseCases.saveToFavorites(news: news)
        await getFavorites()

        #expect(viewModel.favoritesNews.count > favoriteNewsValue)
    }

    @Test func testFetchFavorites() async throws {
        let news1 = News(source: InstantNews.Source(id: nil, name: ""), author: nil, title: "Test News", description: "", url: "1", urlToImage: "", publishedAt: "", content: "", newsType: .science)
        let news2 = News(source: InstantNews.Source(id: nil, name: ""), author: nil, title: "Test News", description: "", url: "2", urlToImage: "", publishedAt: "", content: "", newsType: .science)

        try await favoritesUseCases.saveToFavorites(news: news1)
        try await favoritesUseCases.saveToFavorites(news: news2)
        await getFavorites()

        #expect(viewModel.favoritesNews.count == 2)
    }

    @Test func testErrorHandling() async {
        await getFavorites()
        #expect(viewModel.errorMessage.isEmpty == true)
    }

    private func clearFavorites() async {
        do {
            let emptyFavorites: [News] = []
            let encoded = try? JSONEncoder().encode(emptyFavorites)
            UserDefaults.standard.set(encoded, forKey: "favoriteNews")
        }
    }

    private func getFavorites() async {
        await viewModel.getFavoritesNews()
        await Task.sleep(UInt64(0.5 * 1_000_000_000))
    }
}
