//
//  NewsView-ViewModel.swift
//  InstantNews
//
//  Created by Lucas on 30/01/2025.
//

import Foundation

class NewsViewModel: ObservableObject {
    @Published var news: [News] = []

    @Published var showRecentNewsLoader = false

    @Published var errorMessage = ""
    @Published var showAlert = false

    private let newsUseCases: NewsUseCases

    init(newsUseCases: NewsUseCases) {
        self.newsUseCases = newsUseCases
    }

    private func fetchRecentNews() {
        Task {
            do {
                showRecentNewsLoader = true
                news = try await newsUseCases.fetchRecentNews()
                showRecentNewsLoader = false
            } catch {
                showError(with: error.localizedDescription)
            }
        }
    }

    private func showError(with message: String) {
        errorMessage = message
        showAlert = true
        showRecentNewsLoader = false
    }
}
