//
//  MostRecentNewsView.swift
//  InstantNews
//
//  Created by Lucas on 31/01/2025.
//

import Kingfisher
import Shimmer
import SwiftUI

struct MostRecentNewsView: View {
    @Binding var isLoading: Bool
    @State private var currentIndex = 0

    let news: [News]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Dernières News")
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.darkCharcoal)
                    .padding(.top, 25)
                    .padding(.horizontal)
                Spacer()
            }
            TabView(selection: $currentIndex) {
                ForEach(news.indices, id: \.self) { index in
                    NavigationLink {
                        NewsDetailsView(favoriteUseCases: FavoritesUseCasesImpl(), news: news[index])
                    } label: {
                        ZStack {
                            ZStack {
                                KFImage(URL(string: news[index].urlToImage ?? ""))
                                    .placeholder {
                                        Image("placeholder")
                                            .resizable()
                                    }
                                    .resizable()
                                LinearGradient(colors: [.clear, .darkCharcoal.opacity(0.4), .darkCharcoal], startPoint: .top, endPoint: .bottom)
                            }
                            .redacted(reason: isLoading ? .placeholder : [])
                            .shimmering(active: isLoading ? true : false)
                            VStack(alignment: .leading) {
                                if !isLoading {
                                    HStack {
                                        Spacer()
                                        HStack {
                                            Image(systemName: news[index].newsType?.imageName ?? "soccerball")
                                                .foregroundStyle(.darkCharcoal)
                                            Text(news[index].newsType?.name ?? "Sports")
                                                .font(.footnote.bold())
                                                .foregroundStyle(.darkCharcoal)
                                        }
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 8)
                                        .background(.white)
                                        .clipShape(.capsule)
                                    }
                                }
                                Spacer()
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(news[index].source.name ?? "")
                                            .font(.subheadline.bold())
                                            .foregroundStyle(.white.opacity(0.9))
                                            .padding(.bottom, 1)
                                        Spacer()
                                    }
                                    Text(news[index].title ?? "")
                                        .font(.body.weight(.medium))
                                        .multilineTextAlignment(.leading)
                                        .foregroundStyle(.white)
                                }
                                .redacted(reason: isLoading ? .placeholder : [])
                                .shimmering(active: isLoading ? true : false)
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
                ForEach(news.indices, id: \.self) { index in
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

#Preview {
    MostRecentNewsView(isLoading: .constant(true), news: [])
}
