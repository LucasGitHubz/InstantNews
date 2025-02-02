//
//  NewsView-ViewModel.swift
//  InstantNews
//
//  Created by Lucas on 30/01/2025.
//

import Foundation

class NewsViewModel: ObservableObject {
    @Published private(set) var mostRecentNews: [News] = []
    
    @Published private var news: [News] = [
        News(source: InstantNews.Source(id: nil, name: "SciTechDaily"), author: nil, title: "NASA Unveils a Hidden Universe of Supermassive Black Holes - SciTechDaily", description: "By combining data from NASA’s IRAS and NuSTAR telescopes, scientists have uncovered more hidden supermassive black holes than earlier estimates suggested. Their findings indicate that over a third of these black holes are obscured by thick gas and dust, influ…", url: "https://scitechdaily.com/nasa-unveils-a-hidden-universe-of-supermassive-black-holes/", urlToImage: "https://scitechdaily.com/images/Dust-Torus-Surrounding-Supermassive-Black-Hole-scaled.jpg", publishedAt: "2025-01-30T09:26:18Z", content: "Artistic illustration of the thick dust torus surrounding a supermassive black holes and its accretion disks. Credit: ESA / V. Beckmann (NASA-GSFC)\r\nBy combining data from NASA’s IRAS and NuSTAR tele… [+8653 chars]", newsType: .sports),
        News(source: InstantNews.Source(id: nil, name: "SciTechDaily"), author: nil, title: "NASA Unveils a Hidden Universe of Supermassive Black Holes - SciTechDaily", description: "By combining data from NASA’s IRAS and NuSTAR telescopes, scientists have uncovered more hidden supermassive black holes than earlier estimates suggested. Their findings indicate that over a third of these black holes are obscured by thick gas and dust, influ…", url: "https://scitechdaily.com/nasa-unveils-a-hidden-universe-of-supermassive-black-holes/", urlToImage: "https://scitechdaily.com/images/Dust-Torus-Surrounding-Supermassive-Black-Hole-scaled.jpg", publishedAt: "2025-01-30T09:26:18Z", content: "Artistic illustration of the thick dust torus surrounding a supermassive black holes and its accretion disks. Credit: ESA / V. Beckmann (NASA-GSFC)\r\nBy combining data from NASA’s IRAS and NuSTAR tele… [+8653 chars]", newsType: .business),
        News(source: InstantNews.Source(id: nil, name: "SciTechDaily"), author: nil, title: "NASA Unveils a Hidden Universe of Supermassive Black Holes - SciTechDaily", description: "By combining data from NASA’s IRAS and NuSTAR telescopes, scientists have uncovered more hidden supermassive black holes than earlier estimates suggested. Their findings indicate that over a third of these black holes are obscured by thick gas and dust, influ…", url: "https://scitechdaily.com/nasa-unveils-a-hidden-universe-of-supermassive-black-holes/", urlToImage: "https://scitechdaily.com/images/Dust-Torus-Surrounding-Supermassive-Black-Hole-scaled.jpg", publishedAt: "2025-01-30T09:26:18Z", content: "Artistic illustration of the thick dust torus surrounding a supermassive black holes and its accretion disks. Credit: ESA / V. Beckmann (NASA-GSFC)\r\nBy combining data from NASA’s IRAS and NuSTAR tele… [+8653 chars]", newsType: .entertainment),
        News(source: InstantNews.Source(id: nil, name: "SciTechDaily"), author: nil, title: "NASA Unveils a Hidden Universe of Supermassive Black Holes - SciTechDaily", description: "By combining data from NASA’s IRAS and NuSTAR telescopes, scientists have uncovered more hidden supermassive black holes than earlier estimates suggested. Their findings indicate that over a third of these black holes are obscured by thick gas and dust, influ…", url: "https://scitechdaily.com/nasa-unveils-a-hidden-universe-of-supermassive-black-holes/", urlToImage: "https://scitechdaily.com/images/Dust-Torus-Surrounding-Supermassive-Black-Hole-scaled.jpg", publishedAt: "2025-01-30T09:26:18Z", content: "Artistic illustration of the thick dust torus surrounding a supermassive black holes and its accretion disks. Credit: ESA / V. Beckmann (NASA-GSFC)\r\nBy combining data from NASA’s IRAS and NuSTAR tele… [+8653 chars]", newsType: .technology),
        News(source: InstantNews.Source(id: nil, name: "SciTechDaily"), author: nil, title: "NASA Unveils a Hidden Universe of Supermassive Black Holes - SciTechDaily", description: "By combining data from NASA’s IRAS and NuSTAR telescopes, scientists have uncovered more hidden supermassive black holes than earlier estimates suggested. Their findings indicate that over a third of these black holes are obscured by thick gas and dust, influ…", url: "https://scitechdaily.com/nasa-unveils-a-hidden-universe-of-supermassive-black-holes/", urlToImage: "https://scitechdaily.com/images/Dust-Torus-Surrounding-Supermassive-Black-Hole-scaled.jpg", publishedAt: "2025-01-30T09:26:18Z", content: "Artistic illustration of the thick dust torus surrounding a supermassive black holes and its accretion disks. Credit: ESA / V. Beckmann (NASA-GSFC)\r\nBy combining data from NASA’s IRAS and NuSTAR tele… [+8653 chars]", newsType: .science)
    ]
    @Published private(set) var filteredNews: [News] = []
    @Published var selectedTypeIndex = 0
    
    @Published var errorMessage = ""
    @Published var showAlert = false
    
    @Published var isFirstLoading = true
    @Published var isLoadingMore = false
    @Published var hasMoreNews = true
    
    private var currentPage = 1
    
    private let newsUseCases: NewsUseCases
    
    init(newsUseCases: NewsUseCases) {
        self.newsUseCases = newsUseCases
        
        // Used here as placeholder when first launching
        filteredNews = news
        updateMostRecentNews(news)

        Task {
            await fetchNews()
        }
    }
    
    func fetchNews(loadMore: Bool = false) async {
        guard !isLoadingMore, hasMoreNews else { return }
        Task {
            do {
                let fetchedNews = try await newsUseCases.fetchNews(page: currentPage).shuffled()
                await MainActor.run {
                    isLoadingMore = loadMore
                    if fetchedNews.isEmpty {
                        hasMoreNews = false
                    } else {
                        // Remove the placeholder news from news and mostRecentNews after the firstLaunching
                        if isFirstLoading {
                            news.removeAll()
                            mostRecentNews.removeAll()
                        }
                        news.append(contentsOf: fetchedNews)
                        filteredNews = news
                        if !isLoadingMore {
                            updateMostRecentNews(fetchedNews)
                            isFirstLoading = false
                        }
                        currentPage += 1
                    }
                    filterNewsBasedOnTypeIndex(selectedTypeIndex)
                    isLoadingMore = false
                }
            } catch {
                await MainActor.run {
                    showError(with: error.localizedDescription)
                }
            }
        }
    }
    
    private func updateMostRecentNews(_ fetchedNews: [News]) {
        for newsItem in fetchedNews {
            if !mostRecentNews.contains(where: { $0.newsType == newsItem.newsType }) {
                mostRecentNews.append(newsItem)
            }
        }
    }
    
    private func showError(with message: String) {
        errorMessage = message
        showAlert = true
        isLoadingMore = false
    }
    
    func filterNewsBasedOnTypeIndex(_ index: Int) {
        selectedTypeIndex = index
        switch index {
        case 1: filteredNews = news.filter { $0.newsType == .sports }
        case 2: filteredNews = news.filter { $0.newsType == .business }
        case 3: filteredNews = news.filter { $0.newsType == .entertainment }
        case 4: filteredNews = news.filter { $0.newsType == .science }
        case 5: filteredNews = news.filter { $0.newsType == .technology }
        default: filteredNews = news
        }
    }
}
