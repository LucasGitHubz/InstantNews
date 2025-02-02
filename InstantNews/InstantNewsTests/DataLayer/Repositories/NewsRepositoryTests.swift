//
//  NewsRepositoryTests.swift
//  InstantNewsTests
//
//  Created by Lucas on 02/02/2025.
//

import Testing
@testable import InstantNews

struct NewsRepositoryTests {
    let repository = MockNewsRepository()

    @Test func testFetchNews() async throws {
        let news = try await repository.fetchNews(page: 1)
        #expect(news.count == 2)
    }
}
