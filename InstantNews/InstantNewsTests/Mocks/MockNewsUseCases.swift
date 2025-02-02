//
//  MockNewsUseCases.swift
//  InstantNewsTests
//
//  Created by Lucas on 02/02/2025.
//

import Foundation
@testable import InstantNews

class MockNewsUseCases: NewsUseCases {
    var shouldThrowError = false

    func fetchNews(page: Int) async throws -> [News] {
        if shouldThrowError {
            throw NSError(domain: "MockError", code: 500, userInfo: nil)
        }

        return [
            News(source: InstantNews.Source(id: nil, name: ""), author: nil, title: "", description: "", url: "", urlToImage: "", publishedAt: "", content: "", newsType: .sports),
            News(source: InstantNews.Source(id: nil, name: ""), author: nil, title: "", description: "", url: "", urlToImage: "", publishedAt: "", content: "", newsType: .business)
        ]
    }
}
