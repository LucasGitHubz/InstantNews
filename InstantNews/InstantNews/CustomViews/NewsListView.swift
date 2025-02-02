//
//  NewsListView.swift
//  InstantNews
//
//  Created by Lucas on 31/01/2025.
//

import Kingfisher
import SwiftUI

struct NewsListView: View {
    let news: News

    var body: some View {
        VStack {
            HStack {
                KFImage(URL(string: news.urlToImage ?? ""))
                    .placeholder {
                        Image("placeholder")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 90)
                            .clipShape(.rect(cornerRadius: 12))
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(width: 90)
                    .clipShape(.rect(cornerRadius: 12))
                VStack(alignment: .leading) {
                    HStack {
                        Text(news.newsType?.name ?? "Sports")
                            .font(.footnote)
                            .foregroundStyle(.darkCharcoal.opacity(0.4))
                    }
                    Spacer()
                    Text(news.title ?? "Pas de titre")
                        .font(.footnote.bold())
                        .foregroundStyle(.darkCharcoal)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    HStack {
                        Text(news.author ?? news.source.name ?? "Pas de source")
                            .font(.caption)
                            .foregroundStyle(.darkCharcoal.opacity(0.4))
                        Spacer()
                        Text(news.publishedAt?.formattedAsNewsDate() ?? "")
                            .font(.footnote)
                            .foregroundStyle(.darkCharcoal.opacity(0.4))
                    }
                }
                .padding(.leading, 5)
                Spacer()
            }
            .frame(height: 90)
            Divider()
        }
    }
}

#Preview {
    NewsListView(news: News(source: InstantNews.Source(id: nil, name: "SciTechDaily"), author: nil, title: "NASA Unveils a Hidden Universe of Supermassive Black Holes - SciTechDaily", description: "By combining data from NASA’s IRAS and NuSTAR telescopes, scientists have uncovered more hidden supermassive black holes than earlier estimates suggested. Their findings indicate that over a third of these black holes are obscured by thick gas and dust, influ…", url: "https://scitechdaily.com/nasa-unveils-a-hidden-universe-of-supermassive-black-holes/", urlToImage: "https://scitechdaily.com/images/Dust-Torus-Surrounding-Supermassive-Black-Hole-scaled.jpg", publishedAt: "2025-01-30T09:26:18Z", content: "Artistic illustration of the thick dust torus surrounding a supermassive black holes and its accretion disks. Credit: ESA / V. Beckmann (NASA-GSFC)\r\nBy combining data from NASA’s IRAS and NuSTAR tele… [+8653 chars]", newsType: .sports))
}
