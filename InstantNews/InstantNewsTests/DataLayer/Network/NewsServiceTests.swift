//
//  NewsServiceTests.swift
//  InstantNewsTests
//
//  Created by Lucas on 02/02/2025.
//

import Testing
@testable import InstantNews

struct NewsServiceTests {
    let newsService = MockNewsService(networkService: MockNetworkService())

    @Test func testFetchNewsPagination() async throws {
        newsService.mockNews1 = [
            News(source: InstantNews.Source(id: nil, name: ""), author: nil, title: "", description: "", url: "1", urlToImage: "", publishedAt: "", content: "", newsType: .science),
            News(source: InstantNews.Source(id: nil, name: ""), author: nil, title: "", description: "", url: "1", urlToImage: "", publishedAt: "", content: "", newsType: .technology)
        ]
        newsService.mockNews2 = [
            News(source: InstantNews.Source(id: nil, name: ""), author: nil, title: "", description: "", url: "2", urlToImage: "", publishedAt: "", content: "", newsType: .science),
            News(source: InstantNews.Source(id: nil, name: ""), author: nil, title: "", description: "", url: "2", urlToImage: "", publishedAt: "", content: "", newsType: .technology)
        ]

        let page1 = try await newsService.fetchNewsFromAllType(page: 1, pageSize: 2)
        let page2 = try await newsService.fetchNewsFromAllType(page: 2, pageSize: 2)

        #expect(page1.count == 2)
        #expect(page2.count == 2)
        #expect(page1 != page2)
    }

    @Test func testFetchNewsByType() async throws {
        newsService.mockNews1 = [
            News(source: InstantNews.Source(id: nil, name: ""), author: nil, title: "", description: "", url: "", urlToImage: "", publishedAt: "", content: "", newsType: .science),
            News(source: InstantNews.Source(id: nil, name: ""), author: nil, title: "", description: "", url: "", urlToImage: "", publishedAt: "", content: "", newsType: .technology)
        ]

        let news = try await newsService.fetchNewsFromAllType(page: 1, pageSize: 10)

        #expect(news.contains { $0.newsType == .science })
        #expect(news.contains { $0.newsType == .technology })
    }
}
