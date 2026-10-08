//
//  WikipediaService.swift
//  BucketList
//
//  Created by murad on 08.10.2026.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case badServerResponse
    case decodingFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL address was invalid."
        case .badServerResponse:
            return "Failed to get a valid response from the server."
        case .decodingFailed:
            return "Unable to decode the received data."
        }
    }
}

protocol WikipediaServiceProtocol {
    func fetchNearbyPlaces(latitude: Double, longitude: Double) async throws -> [Page]
}

struct WikipediaService: WikipediaServiceProtocol {
    func fetchNearbyPlaces(latitude: Double, longitude: Double) async throws -> [Page] {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(latitude)%7C\(longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.badServerResponse
        }
        
        do {
            let items = try JSONDecoder().decode(WikipediaResult.self, from: data)
            return items.query.pages.values.sorted()
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
