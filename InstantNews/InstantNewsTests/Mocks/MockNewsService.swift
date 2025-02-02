//
//  MockNewsService.swift
//  InstantNewsTests
//
//  Created by Lucas on 02/02/2025.
//

import Foundation
@testable import InstantNews

class MockNewsService: NewsService {
    var mockNews1: [News] = []
    var mockNews2: [News] = []

    override func fetchNewsFromAllType(page: Int, pageSize: Int) async throws -> [News] {
        return page == 1 ? mockNews1 : mockNews2
    }
}
