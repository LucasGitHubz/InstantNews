//
//  FavoriteView-ViewModel.swift
//  InstantNews
//
//  Created by Lucas on 01/02/2025.
//

import Foundation

class FavoriteViewModel: ObservableObject {
    @Published var favoritesNews: [News] = []
    
    @Published var errorMessage = ""
    @Published var showAlert = false
    
    let favoritesUseCases: FavoritesUseCases
    
    init(favoritesUseCases: FavoritesUseCases) {
        self.favoritesUseCases = favoritesUseCases
        
        Task {
            await getFavoritesNews()
        }
    }
    
    func getFavoritesNews() async {
        do {
            let fetchedFavoriteNews = try await favoritesUseCases.getFavorites()
            await MainActor.run {
                favoritesNews = fetchedFavoriteNews
            }
        } catch {
            showError(error.localizedDescription)
        }
    }
    
    func removeFavorite(atOffsets offsets: IndexSet) {
        for index in offsets {
            let newsToRemove = favoritesNews[index]
            Task {
                do {
                    try await favoritesUseCases.removeFromFavorites(news: newsToRemove)
                    let news = try await favoritesUseCases.getFavorites()
                    await MainActor.run {
                        favoritesNews = news
                    }
                } catch {
                    showError(error.localizedDescription)
                }
            }
        }
    }

    private func showError(_ message: String) {
        errorMessage = message
        showAlert = true
    }
}
