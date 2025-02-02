//
//  NewsDetailsView.swift
//  InstantNews
//
//  Created by Lucas on 30/01/2025.
//

import Kingfisher
import SwiftUI

struct NewsDetailsView: View {
    let favoriteUseCases: FavoritesUseCases
    let news: News

    @State private var isFavorite = false

    @State private var errorMessage = ""
    @State private var showAlert = false

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    ZStack {
                        KFImage(URL(string: news.urlToImage ?? ""))
                            .placeholder {
                                Image("placeholder")
                                    .resizable()
                                    .frame(height: 300)
                            }
                            .resizable()
                            .frame(height: 300)
                        LinearGradient(colors: [.clear,.darkCharcoal.opacity(0.4), .darkCharcoal], startPoint: .top, endPoint: .bottom)
                        VStack(alignment: .leading, spacing: 10) {
                            Spacer()
                            HStack {
                                HStack {
                                    Image(systemName: news.newsType?.imageName ?? "soccerball")
                                        .foregroundStyle(.darkCharcoal)
                                    Text(news.newsType?.name ?? "Sport")
                                        .font(.footnote.bold())
                                        .foregroundStyle(.darkCharcoal)
                                }
                                .padding(.vertical, 5)
                                .padding(.horizontal, 8)
                                .background(.white)
                                .clipShape(.capsule)
                                Spacer()
                            }
                            Text(news.title ?? "Pas de titre")
                                .font(.headline)
                                .foregroundStyle(.white)
                            Text(news.publishedAt?.formattedAsNewsDate() ?? "")
                                .font(.caption.weight(.medium))
                                .foregroundStyle(.white)
                        }
                        .padding()
                        VStack {
                            HStack {
                                Spacer()
                                Button {
                                    Task {
                                        do {
                                            try await favoriteUseCases.toggleFavorite(isFavorite: isFavorite, news: news)
                                            isFavorite.toggle()
                                        } catch {
                                            errorMessage = error.localizedDescription
                                            showAlert = true
                                        }
                                    }
                                } label: {
                                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                                        .font(.title3)
                                        .foregroundStyle(.crimsonRed)
                                        .padding(10)
                                        .background(.white)
                                        .clipShape(.circle)
                                        .animation(.interpolatingSpring, value: isFavorite)
                                }
                                .sensoryFeedback(.success, trigger: isFavorite)
                            }
                            .padding(.top, geometry.safeAreaInsets.top)
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 300)
                    ZStack {
                        Color.darkCharcoal.ignoresSafeArea()
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text(news.source.name ?? "")
                                    .font(.headline)
                                    .foregroundStyle(.darkCharcoal)
                                Spacer()
                            }
                            Text(news.description ?? "")
                                .font(.subheadline.weight(.medium))
                                .foregroundStyle(.darkCharcoal)
                                .multilineTextAlignment(.leading)
                            if let articleURL = news.url, let url = URL(string: articleURL) {
                                Button {
                                    UIApplication.shared.open(url)
                                } label: {
                                    Text("Lire l'article complet")
                                        .underline(true, pattern: .solid)
                                        .foregroundStyle(Color.teal)
                                }
                            }
                            
                            Spacer()
                        }
                        .padding()
                        .background(.beige)
                        .clipShape(UnevenRoundedRectangle(topLeadingRadius: 10, topTrailingRadius: 10))
                    }
                }
            }
            .ignoresSafeArea()
            .background(.beige)
            .task {
                do {
                    isFavorite = try await favoriteUseCases.isFavorite(news: news)
                } catch {
                    errorMessage = error.localizedDescription
                    showAlert = true
                }
            }
            .alert("Oups !", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage)
            }

        }
    }
}

#Preview {
    NewsDetailsView(favoriteUseCases: FavoritesUseCasesImpl(), news: News(source: InstantNews.Source(id: nil, name: "SciTechDaily"), author: nil, title: "NASA Unveils a Hidden Universe of Supermassive Black Holes - SciTechDaily", description: "By combining data from NASA’s IRAS and NuSTAR telescopes, scientists have uncovered more hidden supermassive black holes than earlier estimates suggested. Their findings indicate that over a third of these black holes are obscured by thick gas and dust, influ…", url: "https://scitechdaily.com/nasa-unveils-a-hidden-universe-of-supermassive-black-holes/", urlToImage: "https://scitechdaily.com/images/Dust-Torus-Surrounding-Supermassive-Black-Hole-scaled.jpg", publishedAt: "2025-01-30T09:26:18Z", content: "Artistic illustration of the thick dust torus surrounding a supermassive black holes and its accretion disks. Credit: ESA / V. Beckmann (NASA-GSFC)\r\nBy combining data from NASA’s IRAS and NuSTAR tele… [+8653 chars]", newsType: .sports))
}
