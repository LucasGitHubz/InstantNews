//
//  NewsService.swift
//  InstantNews
//
//  Created by Lucas on 30/01/2025.
//

import Foundation

class NewsService {
    private let networkService: NetworkServiceProtocol
    
    private let apiKey = Bundle.main.apiKey(for: "NewsApiKey") ?? "nil"
    private let baseURL = "https://newsapi.org/v2/everything"
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchNewsFromAllType(page: Int, pageSize: Int = 10) async throws -> [News] {
        var newsArray: [News] = []
        
        try await withThrowingTaskGroup(of: [News].self) { group in
            for newsType in NewsType.allCases {
                group.addTask {
                    return try await self.fetchNews(for: newsType, page: page, pageSize: pageSize)
                }
            }
            
            for try await news in group {
                newsArray += news
            }
        }
        
        return newsArray
    }
    
    private func fetchNews(for type: NewsType, page: Int, pageSize: Int) async throws -> [News] {
        guard let url = URL(string: "\(baseURL)?q=\(type.rawValue)&apiKey=\(apiKey)&page=\(page)&pageSize=\(pageSize)&language=fr") else {
            throw NetworkError.invalidResponse
        }

        let response: NewsResponse = try await networkService.request(from: url, decodingType: NewsResponse.self)

        guard var fetchedNews = response.articles else { return [] }

        for index in 0..<fetchedNews.count {
            fetchedNews[index].newsType = type
        }
        
        return fetchedNews
    }
}
