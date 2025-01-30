//
//  NewsEntity.swift
//  InstantNews
//
//  Created by Lucas on 30/01/2025.
//

import Foundation

enum NewsType: String, Decodable, CaseIterable {
    case sports, business, entertainment, science, technology
}

struct NewsResponse: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [News]?
}

struct News: Decodable, Identifiable {
    let id = UUID()
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
