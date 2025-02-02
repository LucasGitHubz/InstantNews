//
//  NewsUseCasesTests.swift
//  InstantNewsTests
//
//  Created by Lucas on 02/02/2025.
//

import Testing
@testable import InstantNews

struct NewsUseCasesTests {
    let useCase = NewsUseCasesImpl(repository: MockNewsRepository())

    @Test func testFetchNews() async throws {
        let news = try await useCase.fetchNews(page: 1)
        #expect(news.count == 2)
    }
}
