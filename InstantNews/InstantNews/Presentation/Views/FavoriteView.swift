//
//  FavoriteView.swift
//  InstantNews
//
//  Created by Lucas on 30/01/2025.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var viewModel: FavoriteViewModel
    
    var body: some View {
        Group {
            if viewModel.favoritesNews.isEmpty {
                ZStack {
                    Color.beige
                        .ignoresSafeArea()
                    Text("Pas encore de news enregistrée.")
                        .font(.headline)
                        .foregroundStyle(.darkCharcoal)
                }
            } else {
                List {
                    ForEach(viewModel.favoritesNews.indices, id: \.self) { index in
                        NavigationLink {
                            NewsDetailsView(favoriteUseCases: FavoritesUseCasesImpl(), news: viewModel.favoritesNews[index])
                        } label: {
                            NewsListView(news: viewModel.favoritesNews[index])
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                    }
                    .onDelete { indexSet in
                        viewModel.removeFavorite(atOffsets: indexSet)
                    }
                }
                .listStyle(.plain)
                .background(.beige)
                .onAppear {
                    Task {
                        await viewModel.getFavoritesNews()
                    }
                }
            }
        }
        .navigationTitle("Tes News")
    }
}

#Preview {
    FavoriteView(viewModel: FavoriteViewModel(favoritesUseCases: FavoritesUseCasesImpl()))
}
