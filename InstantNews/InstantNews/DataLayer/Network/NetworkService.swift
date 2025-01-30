//
//  NetworkService.swift
//  InstantNews
//
//  Created by Lucas on 30/01/2025.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case decodingError(Error)
}

protocol NetworkServiceProtocol {
    func request<T: Decodable>(from url: URL, decodingType: T.Type) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
    func request<T: Decodable>(from url: URL, decodingType: T.Type) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}
