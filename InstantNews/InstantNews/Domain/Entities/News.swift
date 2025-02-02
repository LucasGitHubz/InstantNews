//
//  NewsEntity.swift
//  InstantNews
//
//  Created by Lucas on 30/01/2025.
//

import Foundation

enum NewsType: String, Codable, CaseIterable {
    case sports, business, entertainment, science, technology
    
    var name: String {
        switch self {
        case .sports: return "Sports"
        case .business: return "Business"
        case .entertainment: return "Divertissement"
        case .science: return "Science"
        case .technology: return "Technologie"
        }
    }

    var imageName: String {
        switch self {
        case .sports: return "soccerball"
        case .business: return "chart.bar"
        case .entertainment: return "music.note"
        case .science: return "atom"
        case .technology: return "cpu"
        }
    }

    var index: Int {
        switch self {
        case .sports: return 1
        case .business: return 2
        case .entertainment: return 3
        case .science: return 4
        case .technology: return 5
        }
    }
}

struct NewsResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [News]?
}

struct News: Codable, Equatable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    var newsType: NewsType?

    static func == (lhs: News, rhs: News) -> Bool {
        return lhs.url == rhs.url
    }
}

struct Source: Codable {
    let id: String?
    let name: String?
}
