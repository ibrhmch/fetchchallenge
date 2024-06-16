//
//  MockNetworkingService.swift
//  fetchchallenge
//
//  Created by octopus on 6/16/24.
//

import Foundation

class MockNetworkingService: NetworkingServiceProtocol {
    var fetchDataHandler: ((URL) async throws -> Data)?
    
    func fetchData<T: Decodable>(from url: URL) async throws -> T {
        if let fetchDataHandler = fetchDataHandler {
            let data = try await fetchDataHandler(url)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        }
        throw URLError(.badURL)
    }
}
