//
//  MockNewsRepository.swift
//  InstantNewsTests
//
//  Created by Lucas on 02/02/2025.
//

import Foundation
@testable import InstantNews

class MockNewsRepository: NewsRepository {
    var mockNews: [News] = [
        News(source: InstantNews.Source(id: nil, name: ""), author: nil, title: "", description: "", url: "", urlToImage: "", publishedAt: "", content: "", newsType: .science),
        News(source: InstantNews.Source(id: nil, name: ""), author: nil, title: "", description: "", url: "", urlToImage: "", publishedAt: "", content: "", newsType: .science)
    ]

    func fetchNews(page: Int) async throws -> [News] {
        return mockNews
    }
}
