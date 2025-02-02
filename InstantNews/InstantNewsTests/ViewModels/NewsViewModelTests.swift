//
//  NewsViewModelTests.swift
//  InstantNewsTests
//
//  Created by Lucas on 02/02/2025.
//

import Testing
@testable import InstantNews

struct NewsViewModelTests {
    let mockUseCases = MockNewsUseCases()
    let viewModel: NewsViewModel

    init() {
        self.viewModel = NewsViewModel(newsUseCases: mockUseCases)
    }

    @Test func testInitialState() async {
        #expect(viewModel.isFirstLoading == true)
        #expect(viewModel.isLoadingMore == false)
        #expect(viewModel.hasMoreNews == true)
        #expect(viewModel.filteredNews.count == 5)
    }

    @Test func testFetchInitialNews() async {
        await getNews()
        
        #expect(viewModel.isFirstLoading == false)
        #expect(viewModel.filteredNews.isEmpty == false)
        #expect(viewModel.filteredNews.count == 2)
    }

    @Test func testPagination() async {
        await getNews()

        let initialCount = viewModel.filteredNews.count

        await getNews(loadMore: true)

        let newCount = viewModel.filteredNews.count

        #expect(newCount > initialCount)
    }

    @Test func testFiltering() async {
        await getNews()
        
        viewModel.filterNewsBasedOnTypeIndex(1)
        #expect(viewModel.filteredNews.count == 1)
        #expect(viewModel.filteredNews.allSatisfy { $0.newsType == .sports })

        viewModel.filterNewsBasedOnTypeIndex(2)
        #expect(viewModel.filteredNews.count == 1)
        #expect(viewModel.filteredNews.allSatisfy { $0.newsType == .business })

        viewModel.filterNewsBasedOnTypeIndex(0)
        #expect(viewModel.filteredNews.count == 2)
    }

    @Test func testFetchNewsWithError() async {
        mockUseCases.shouldThrowError = true

        await getNews()

        #expect(viewModel.errorMessage.isEmpty == false)
        #expect(viewModel.showAlert == true)
    }

    private func getNews(loadMore: Bool = false) async {
        await viewModel.fetchNews(loadMore: loadMore)
        await Task.sleep(UInt64(0.5 * 1_000_000_000))
    }
}
