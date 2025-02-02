//
//  NetworkServiceTests.swift
//  InstantNewsTests
//
//  Created by Lucas on 02/02/2025.
//

import Testing
@testable import InstantNews
import Foundation

import Testing
@testable import InstantNews

struct NetworkServiceTests {
    let networkService = MockNetworkService()

    @Test func testSuccessfulAPIResponse() async throws {
        let mockJSON = """
        {
            "status": "ok",
            "articles": [{"source": {"id": "1", "name": "Mock"}, "title": "Test Article"}]
        }
        """.data(using: .utf8)

        networkService.mockResponse = mockJSON

        let url = URL(string: "https://mockapi.com")!
        let response: NewsResponse = try await networkService.request(from: url, decodingType: NewsResponse.self)

        #expect(response.articles?.isEmpty == false)
    }

    @Test func testInvalidURL() async {
        networkService.mockError = NetworkError.invalidResponse

        do {
            _ = try await networkService.request(from: URL(string: "invalid-url")!, decodingType: NewsResponse.self)
            Issue.record("Expected an error but got a response")
        } catch {
            #expect(error is NetworkError)
        }
    }
}
