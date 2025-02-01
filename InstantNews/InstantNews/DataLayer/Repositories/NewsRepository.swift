//
//  NewsRepository.swift
//  InstantNews
//
//  Created by Lucas on 30/01/2025.
//

import Foundation

protocol NewsRepository {
    func fetchNews(page: Int) async throws -> [News]
}

class NewsRepositoryImpl: NewsRepository {
    private let newsService: NewsService

    init(newsService: NewsService) {
        self.newsService = newsService
    }

    func fetchNews(page: Int) async throws -> [News] {
        return try await newsService.fetchNewsFromAllType(page: page)
    }
}
