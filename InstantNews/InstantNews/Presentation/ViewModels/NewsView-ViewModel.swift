//
//  NewsView-ViewModel.swift
//  InstantNews
//
//  Created by Lucas on 30/01/2025.
//

import Foundation

class NewsViewModel: ObservableObject {
    @Published var mostRecentNews: [News] = [
        News(source: InstantNews.Source(id: nil, name: "SciTechDaily"), author: nil, title: "NASA Unveils a Hidden Universe of Supermassive Black Holes - SciTechDaily", description: "By combining data from NASA’s IRAS and NuSTAR telescopes, scientists have uncovered more hidden supermassive black holes than earlier estimates suggested. Their findings indicate that over a third of these black holes are obscured by thick gas and dust, influ…", url: "https://scitechdaily.com/nasa-unveils-a-hidden-universe-of-supermassive-black-holes/", urlToImage: "https://scitechdaily.com/images/Dust-Torus-Surrounding-Supermassive-Black-Hole-scaled.jpg", publishedAt: "2025-01-30T09:26:18Z", content: "Artistic illustration of the thick dust torus surrounding a supermassive black holes and its accretion disks. Credit: ESA / V. Beckmann (NASA-GSFC)\r\nBy combining data from NASA’s IRAS and NuSTAR tele… [+8653 chars]", newsType: .sports),
        News(source: InstantNews.Source(id: nil, name: "SciTechDaily"), author: nil, title: "NASA Unveils a Hidden Universe of Supermassive Black Holes - SciTechDaily", description: "By combining data from NASA’s IRAS and NuSTAR telescopes, scientists have uncovered more hidden supermassive black holes than earlier estimates suggested. Their findings indicate that over a third of these black holes are obscured by thick gas and dust, influ…", url: "https://scitechdaily.com/nasa-unveils-a-hidden-universe-of-supermassive-black-holes/", urlToImage: "https://scitechdaily.com/images/Dust-Torus-Surrounding-Supermassive-Black-Hole-scaled.jpg", publishedAt: "2025-01-30T09:26:18Z", content: "Artistic illustration of the thick dust torus surrounding a supermassive black holes and its accretion disks. Credit: ESA / V. Beckmann (NASA-GSFC)\r\nBy combining data from NASA’s IRAS and NuSTAR tele… [+8653 chars]", newsType: .business),
        News(source: InstantNews.Source(id: nil, name: "SciTechDaily"), author: nil, title: "NASA Unveils a Hidden Universe of Supermassive Black Holes - SciTechDaily", description: "By combining data from NASA’s IRAS and NuSTAR telescopes, scientists have uncovered more hidden supermassive black holes than earlier estimates suggested. Their findings indicate that over a third of these black holes are obscured by thick gas and dust, influ…", url: "https://scitechdaily.com/nasa-unveils-a-hidden-universe-of-supermassive-black-holes/", urlToImage: "https://scitechdaily.com/images/Dust-Torus-Surrounding-Supermassive-Black-Hole-scaled.jpg", publishedAt: "2025-01-30T09:26:18Z", content: "Artistic illustration of the thick dust torus surrounding a supermassive black holes and its accretion disks. Credit: ESA / V. Beckmann (NASA-GSFC)\r\nBy combining data from NASA’s IRAS and NuSTAR tele… [+8653 chars]", newsType: .entertainment),
        News(source: InstantNews.Source(id: nil, name: "SciTechDaily"), author: nil, title: "NASA Unveils a Hidden Universe of Supermassive Black Holes - SciTechDaily", description: "By combining data from NASA’s IRAS and NuSTAR telescopes, scientists have uncovered more hidden supermassive black holes than earlier estimates suggested. Their findings indicate that over a third of these black holes are obscured by thick gas and dust, influ…", url: "https://scitechdaily.com/nasa-unveils-a-hidden-universe-of-supermassive-black-holes/", urlToImage: "https://scitechdaily.com/images/Dust-Torus-Surrounding-Supermassive-Black-Hole-scaled.jpg", publishedAt: "2025-01-30T09:26:18Z", content: "Artistic illustration of the thick dust torus surrounding a supermassive black holes and its accretion disks. Credit: ESA / V. Beckmann (NASA-GSFC)\r\nBy combining data from NASA’s IRAS and NuSTAR tele… [+8653 chars]", newsType: .technology),
        News(source: InstantNews.Source(id: nil, name: "SciTechDaily"), author: nil, title: "NASA Unveils a Hidden Universe of Supermassive Black Holes - SciTechDaily", description: "By combining data from NASA’s IRAS and NuSTAR telescopes, scientists have uncovered more hidden supermassive black holes than earlier estimates suggested. Their findings indicate that over a third of these black holes are obscured by thick gas and dust, influ…", url: "https://scitechdaily.com/nasa-unveils-a-hidden-universe-of-supermassive-black-holes/", urlToImage: "https://scitechdaily.com/images/Dust-Torus-Surrounding-Supermassive-Black-Hole-scaled.jpg", publishedAt: "2025-01-30T09:26:18Z", content: "Artistic illustration of the thick dust torus surrounding a supermassive black holes and its accretion disks. Credit: ESA / V. Beckmann (NASA-GSFC)\r\nBy combining data from NASA’s IRAS and NuSTAR tele… [+8653 chars]", newsType: .science)
    ]
    
    @Published private var news: [News] = [
        News(source: InstantNews.Source(id: nil, name: "SciTechDaily"), author: nil, title: "NASA Unveils a Hidden Universe of Supermassive Black Holes - SciTechDaily", description: "By combining data from NASA’s IRAS and NuSTAR telescopes, scientists have uncovered more hidden supermassive black holes than earlier estimates suggested. Their findings indicate that over a third of these black holes are obscured by thick gas and dust, influ…", url: "https://scitechdaily.com/nasa-unveils-a-hidden-universe-of-supermassive-black-holes/", urlToImage: "https://scitechdaily.com/images/Dust-Torus-Surrounding-Supermassive-Black-Hole-scaled.jpg", publishedAt: "2025-01-30T09:26:18Z", content: "Artistic illustration of the thick dust torus surrounding a supermassive black holes and its accretion disks. Credit: ESA / V. Beckmann (NASA-GSFC)\r\nBy combining data from NASA’s IRAS and NuSTAR tele… [+8653 chars]", newsType: .sports),
        News(source: InstantNews.Source(id: nil, name: "SciTechDaily"), author: nil, title: "NASA Unveils a Hidden Universe of Supermassive Black Holes - SciTechDaily", description: "By combining data from NASA’s IRAS and NuSTAR telescopes, scientists have uncovered more hidden supermassive black holes than earlier estimates suggested. Their findings indicate that over a third of these black holes are obscured by thick gas and dust, influ…", url: "https://scitechdaily.com/nasa-unveils-a-hidden-universe-of-supermassive-black-holes/", urlToImage: "https://scitechdaily.com/images/Dust-Torus-Surrounding-Supermassive-Black-Hole-scaled.jpg", publishedAt: "2025-01-30T09:26:18Z", content: "Artistic illustration of the thick dust torus surrounding a supermassive black holes and its accretion disks. Credit: ESA / V. Beckmann (NASA-GSFC)\r\nBy combining data from NASA’s IRAS and NuSTAR tele… [+8653 chars]", newsType: .business),
        News(source: InstantNews.Source(id: nil, name: "SciTechDaily"), author: nil, title: "NASA Unveils a Hidden Universe of Supermassive Black Holes - SciTechDaily", description: "By combining data from NASA’s IRAS and NuSTAR telescopes, scientists have uncovered more hidden supermassive black holes than earlier estimates suggested. Their findings indicate that over a third of these black holes are obscured by thick gas and dust, influ…", url: "https://scitechdaily.com/nasa-unveils-a-hidden-universe-of-supermassive-black-holes/", urlToImage: "https://scitechdaily.com/images/Dust-Torus-Surrounding-Supermassive-Black-Hole-scaled.jpg", publishedAt: "2025-01-30T09:26:18Z", content: "Artistic illustration of the thick dust torus surrounding a supermassive black holes and its accretion disks. Credit: ESA / V. Beckmann (NASA-GSFC)\r\nBy combining data from NASA’s IRAS and NuSTAR tele… [+8653 chars]", newsType: .entertainment),
        News(source: InstantNews.Source(id: nil, name: "SciTechDaily"), author: nil, title: "NASA Unveils a Hidden Universe of Supermassive Black Holes - SciTechDaily", description: "By combining data from NASA’s IRAS and NuSTAR telescopes, scientists have uncovered more hidden supermassive black holes than earlier estimates suggested. Their findings indicate that over a third of these black holes are obscured by thick gas and dust, influ…", url: "https://scitechdaily.com/nasa-unveils-a-hidden-universe-of-supermassive-black-holes/", urlToImage: "https://scitechdaily.com/images/Dust-Torus-Surrounding-Supermassive-Black-Hole-scaled.jpg", publishedAt: "2025-01-30T09:26:18Z", content: "Artistic illustration of the thick dust torus surrounding a supermassive black holes and its accretion disks. Credit: ESA / V. Beckmann (NASA-GSFC)\r\nBy combining data from NASA’s IRAS and NuSTAR tele… [+8653 chars]", newsType: .technology),
        News(source: InstantNews.Source(id: nil, name: "SciTechDaily"), author: nil, title: "NASA Unveils a Hidden Universe of Supermassive Black Holes - SciTechDaily", description: "By combining data from NASA’s IRAS and NuSTAR telescopes, scientists have uncovered more hidden supermassive black holes than earlier estimates suggested. Their findings indicate that over a third of these black holes are obscured by thick gas and dust, influ…", url: "https://scitechdaily.com/nasa-unveils-a-hidden-universe-of-supermassive-black-holes/", urlToImage: "https://scitechdaily.com/images/Dust-Torus-Surrounding-Supermassive-Black-Hole-scaled.jpg", publishedAt: "2025-01-30T09:26:18Z", content: "Artistic illustration of the thick dust torus surrounding a supermassive black holes and its accretion disks. Credit: ESA / V. Beckmann (NASA-GSFC)\r\nBy combining data from NASA’s IRAS and NuSTAR tele… [+8653 chars]", newsType: .science)
    ]
    @Published private(set) var filteredNews: [News] = []
    @Published var selectedTypeIndex = 0
    
    @Published var showRecentNewsLoader = false
    
    @Published var errorMessage = ""
    @Published var showAlert = false
    
    private let newsUseCases: NewsUseCases
    
    init(newsUseCases: NewsUseCases) {
        self.newsUseCases = newsUseCases
        
        //fetchRecentNews()
    }
    
    private func fetchRecentNews() {
        Task {
            do {
                showRecentNewsLoader = true
                mostRecentNews = try await newsUseCases.fetchRecentNews()
                showRecentNewsLoader = false
                print("success: \(news)")
            } catch {
                print("error: \(error.localizedDescription)")
                showError(with: error.localizedDescription)
            }
        }
    }
    
    private func showError(with message: String) {
        errorMessage = message
        showAlert = true
        showRecentNewsLoader = false
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
