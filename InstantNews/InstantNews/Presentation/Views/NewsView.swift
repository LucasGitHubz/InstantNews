//
//  NewsView.swift
//  InstantNews
//
//  Created by Lucas on 30/01/2025.
//

import SwiftUI

struct NewsView: View {
    @ObservedObject var viewModel: NewsViewModel
    @State private var currentIndex = 0
    let items = ["View 1", "View 2", "View 3", "View 4", "View 5"]

    var body: some View {
        ZStack {
            Color.beige
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                    VStack {
                        HStack {
                            Text("Dernières News")
                                .font(.headline)
                                .padding(.top, 25)
                                .padding(.horizontal)
                            Spacer()
                        }
                        TabView(selection: $currentIndex) {
                            ForEach(viewModel.news, id: \.id) { news in
                                NavigationLink {
                                    Text("")
                                } label: {
                                    VStack {
                                        
                                    }
                                }
                                
                                /*Text(items[index])
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                                    .tag(index)*/
                            }
                        }
                        .frame(height: 200)
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        HStack(spacing: 10) {
                            ForEach(items.indices, id: \.self) { index in
                                Circle()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(currentIndex == index ? .blue : .gray)
                            }
                        }
                        .padding(.bottom)
                    }
                }
            }
        }
        .navigationTitle("Instant News")
    }
}

#Preview {
    NewsView(viewModel: NewsViewModel(newsUseCases: NewsUseCasesImpl(repository: NewsRepositoryImpl(newsService: NewsService(networkService: NetworkService())))))
}
