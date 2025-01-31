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
        print("\n🔵 [REQUEST] API Call: \(url.absoluteString)")

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse else {
                print("🔴 [ERROR] Response is not an HTTPURLResponse")
                throw NetworkError.invalidResponse
            }

            print("🟢 [RESPONSE] Status: \(httpResponse.statusCode) \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")

            guard (200...299).contains(httpResponse.statusCode) else {
                print("🔴 [ERROR] Invalid status code \(httpResponse.statusCode)")
                throw NetworkError.invalidResponse
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                print("✅ [SUCCESS] Decoded Response: \(decodedData)")
                return decodedData
            } catch {
                print("🔴 [ERROR] Decoding Failed: \(error.localizedDescription)")
                throw NetworkError.decodingError(error)
            }
        } catch {
            print("🔴 [ERROR] Network Request Failed: \(error.localizedDescription)")
            throw error
        }
    }
}
