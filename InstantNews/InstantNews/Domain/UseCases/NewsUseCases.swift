//
//  NewsUseCases.swift
//  InstantNews
//
//  Created by Lucas on 30/01/2025.
//

import Foundation

protocol NewsUseCases {
    func fetchNews() async throws -> [News]
}

class NewsUseCasesImpl: NewsUseCases {
    private let repository: NewsRepository
    
    init(repository: NewsRepository) {
        self.repository = repository
    }

    func fetchNews() async throws -> [News] {
        return try await repository.fetchNews()
    }
}
