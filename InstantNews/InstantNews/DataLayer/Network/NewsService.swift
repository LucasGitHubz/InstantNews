//
//  NewsService.swift
//  InstantNews
//
//  Created by Lucas on 30/01/2025.
//

import Foundation

class NewsService {
    private let networkService: NetworkService
    
    private let apiKey = Bundle.main.apiKey(for: "NewsApiKey") ?? "nil"
    private let baseURL = "https://newsapi.org/v2/everything"
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchNewsFromAllType() async throws -> [News] {
        var newsArray: [News] = []
        
        try await withThrowingTaskGroup(of: [News].self) { group in
            for newsType in NewsType.allCases {
                group.addTask {
                    return try await self.fetchNews(for: newsType)
                }
            }
            
            for try await news in group {
                newsArray += news
            }
        }
        
        return newsArray
    }
    
    private func fetchNews(for type: NewsType) async throws -> [News] {
        guard let url = URL(string: "\(baseURL)?q=\(type.rawValue)&apiKey=\(apiKey)&pageSize=\(10)&language=fr") else {
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
