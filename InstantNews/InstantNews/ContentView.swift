//
//  ContentView.swift
//  InstantNews
//
//  Created by Lucas on 30/01/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    @State private var tabSelected: TabBarType = .news

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.4)
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.darkCharcoal]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.darkCharcoal]
        UINavigationBar.appearance().standardAppearance = appearance
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        NavigationStack {
            TabView(selection: $tabSelected) {
                NavigationView {
                    displayAssociatedView(type: tabSelected)
                        .id(appState.rootViewId)
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .accentColor(.white)
            }
            .safeAreaInset(edge: .bottom) {
                CustomTabBar(selectedTab: $tabSelected)
                    .ignoresSafeArea()
            }
        }
        .tint(.white)
    }

    func displayAssociatedView(type: TabBarType) -> some View {
        switch type {
        case .news: return AnyView(NewsView(viewModel: NewsViewModel(newsUseCases: NewsUseCasesImpl(repository: NewsRepositoryImpl(newsService: NewsService(networkService: NetworkService()))))))
        case .favorite: return AnyView(FavoriteView())
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
