//
//  NetworkProvider.swift
//  SephoreTest
//
//  Created by Jeromin Lebon on 05/01/2024.
//

import Foundation

enum Endpoint {
    case listing
    case images(String)

    var base: String {
        switch self {
        case .listing:
            return "https://sephoraios.github.io"
        case.images:
            return ""
        }
    }

    var path: String {
        switch self {
        case .listing:
            return "/items.json"
        case .images(let url):
            return "\(url)"
        }
    }
}

protocol NetworkProviderProtocol {
    func request(endpoint: Endpoint) async throws -> Data
}

final class NetworkProvider: NetworkProviderProtocol {
    public static let shared = NetworkProvider()
    func request(endpoint: Endpoint) async throws -> Data {
        guard let url = URL(string: endpoint.base+endpoint.path)
        else {
            throw NetworkError.badUrl
        }

        let request = URLRequest(url: url)

        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            throw NetworkError.badRequest
        }

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.statusCode
        }

        return data
    }
}
