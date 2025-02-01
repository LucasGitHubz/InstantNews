//
//  NewsView.swift
//  InstantNews
//
//  Created by Lucas on 30/01/2025.
//

import Kingfisher
import SwiftUI

struct NewsView: View {
    @ObservedObject var viewModel: NewsViewModel

    @State private var selectedTypeIndex = 0
    
    var body: some View {
        ZStack {
            Color.beige
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                    MostRecentNewsView(news: viewModel.mostRecentNews)
                    ScrollView(.horizontal) {
                        HStack {
                            NewsTypeButtonView(isSelected: viewModel.selectedTypeIndex == 0, name: "Tous") {
                                viewModel.filterNewsBasedOnTypeIndex(0)
                            }
                            ForEach(NewsType.allCases, id: \.self) { type in
                                NewsTypeButtonView(isSelected: viewModel.selectedTypeIndex == type.index, name: type.rawValue) {
                                    viewModel.filterNewsBasedOnTypeIndex(type.index)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .scrollIndicators(.hidden)
                    LazyVStack(spacing: 10) {
                        ForEach(viewModel.filteredNews.indices, id: \.self) { index in
                            NavigationLink {
                                NewsDetailsView(favoriteUseCases: FavoritesUseCasesImpl(), news: viewModel.filteredNews[index])
                            } label: {
                                NewsListView(news: viewModel.filteredNews[index])
                            }
                            .animation(.spring(response: 0.2, dampingFraction: 0.9, blendDuration: 0), value: viewModel.selectedTypeIndex)
                        }
                    }
                    .padding()
                }
                .padding(.bottom, 60)
            }
        }
        .navigationTitle("Instant News")
    }
}

#Preview {
    NewsView(viewModel: NewsViewModel(newsUseCases: NewsUseCasesImpl(repository: NewsRepositoryImpl(newsService: NewsService(networkService: NetworkService())))))
}
