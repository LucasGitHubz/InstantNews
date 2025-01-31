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
    private let baseURL = "https://newsapi.org/v2/top-headlines"
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchRecentsNews() async throws -> [News] {
        var newsArray: [News] = []
        
        try await withThrowingTaskGroup(of: News?.self) { group in
            for newsType in NewsType.allCases {
                group.addTask {
                    return try await self.fetchLatestNews(for: newsType)
                }
            }
            
            for try await news in group {
                if let news = news {
                    newsArray.append(news)
                }
            }
        }
        
        return newsArray
    }
    
    private func fetchLatestNews(for type: NewsType) async throws -> News? {
        guard let url = URL(string: "\(baseURL)?category=\(type.rawValue)&apiKey=\(apiKey)&pageSize=1") else {
            throw NetworkError.invalidResponse
        }

        let response: NewsResponse = try await networkService.request(from: url, decodingType: NewsResponse.self)
        
        print("test2 \(response.articles?.count)")
        guard let latestNews = response.articles?.first else { return nil }
        
        print("test3 \(latestNews)")
        var updatedNews = latestNews
        updatedNews.newsType = type
        
        return updatedNews
    }
}
