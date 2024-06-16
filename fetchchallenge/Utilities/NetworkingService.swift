//
//  NetworkingService.swift
//  fetchchallenge
//
//  Created by octopus on 6/15/24.
//

import Foundation

protocol NetworkingServiceProtocol {
    func fetchData<T: Decodable>(from url: URL) async throws -> T
}

struct NetworkingService: NetworkingServiceProtocol {
    static let shared = NetworkingService()
    
    private init() {}
    
    func fetchData<T: Decodable>(from url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
