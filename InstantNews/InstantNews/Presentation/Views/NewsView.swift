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

    @State private var currentIndex = 0
    
    var body: some View {
        ZStack {
            Color.beige
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                    VStack(spacing: 0) {
                        HStack {
                            Text("Dernières News")
                                .font(.headline)
                                .padding(.top, 25)
                                .padding(.horizontal)
                            Spacer()
                        }
                        TabView(selection: $currentIndex) {
                            ForEach(viewModel.news.indices, id: \.self) { index in
                                NavigationLink {
                                    Text("")
                                } label: {
                                    ZStack {
                                        KFImage(URL(string: viewModel.news[index].urlToImage ?? ""))
                                            .placeholder {
                                                Image("placeholder")
                                                    .resizable()
                                            }
                                            .resizable()
                                        LinearGradient(colors: [.clear, .darkCharcoal.opacity(0.4), .darkCharcoal], startPoint: .top, endPoint: .bottom)
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Spacer()
                                                HStack {
                                                    Image(systemName: viewModel.news[index].newsType?.imageName ?? "soccerball")
                                                        .foregroundStyle(.darkCharcoal)
                                                    Text(viewModel.news[index].newsType?.name ?? "Sport")
                                                        .font(.footnote.bold())
                                                        .foregroundStyle(.darkCharcoal)
                                                }
                                                .padding(.vertical, 5)
                                                .padding(.horizontal, 8)
                                                .background(.white)
                                                .clipShape(.capsule)
                                            }
                                            Spacer()
                                            Text(viewModel.news[index].source.name ?? "")
                                                .font(.subheadline.bold())
                                                .foregroundStyle(.white.opacity(0.9))
                                                .padding(.bottom, 1)
                                            Text(viewModel.news[index].title ?? "")
                                                .font(.body.weight(.medium))
                                                .multilineTextAlignment(.leading)
                                                .foregroundStyle(.white)
                                        }
                                        .padding()
                                    }
                                    .frame(height: 200)
                                    .clipShape(.rect(cornerRadius: 15))
                                    .shadow(radius: 5)
                                    .padding()
                                    
                                }
                                .tag(index)
                            }
                        }
                        .frame(height: 230)
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        HStack(spacing:7) {
                            ForEach(viewModel.news.indices, id: \.self) { index in
                                Capsule()
                                    .frame(width: currentIndex == index ? 20 : 8, height: 8)
                                    .foregroundColor(currentIndex == index ? .darkCharcoal : .gray.opacity(0.4))
                                    .animation(.spring(response: 0.2, dampingFraction: 0.9, blendDuration: 0), value: currentIndex)
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
