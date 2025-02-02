//
//  MockNetworkService.swift
//  InstantNewsTests
//
//  Created by Lucas on 02/02/2025.
//

import Foundation
@testable import InstantNews

class MockNetworkService: NetworkServiceProtocol {
    var mockResponse: Data?
    var mockError: Error?

    func request<T: Decodable>(from url: URL, decodingType: T.Type) async throws -> T {
        if let error = mockError {
            throw error
        }

        guard let data = mockResponse else {
            throw NetworkError.invalidResponse
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
