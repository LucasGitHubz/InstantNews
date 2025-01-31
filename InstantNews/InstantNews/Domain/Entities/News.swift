//
//  NewsEntity.swift
//  InstantNews
//
//  Created by Lucas on 30/01/2025.
//

import Foundation

enum NewsType: String, Decodable, CaseIterable {
    case sports, business, entertainment, science, technology
    
    var name: String {
        switch self {
        case .sports: return "Sports"
        case .business: return "Business"
        case .entertainment: return "Entertainment"
        case .science: return "Science"
        case .technology: return "Technology"
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
}

struct NewsResponse: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [News]?
}

struct News: Decodable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    var newsType: NewsType?
}

struct Source: Decodable {
    let id: String?
    let name: String?
}
