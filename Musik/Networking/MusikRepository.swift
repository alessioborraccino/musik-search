//
//  MusikRepository.swift
//  Musik
//
//

import Foundation
import ABNetworking

final class MusikRepository {
    private let apiClient: JsonApiClient
    private let jsonDecoder: JSONDecoder = JSONDecoder()

    init(client: JsonApiClient) {
        self.apiClient = client
    }

    public convenience init() {
        self.init(client: JsonApiClient())
    }
}

extension MusikRepository {
    func search(query: String) async throws -> [SearchResult] {
        
        let results: SearchResults = try await apiClient.start(MusikApiRequest.SearchArtists(query: query),
                                                               using: jsonDecoder)
        try Task.checkCancellation()
        return results.results
    }

    func getArtist(id: Int) async throws -> Artist {
        let artist: Artist = try await apiClient.start(MusikApiRequest.GetArtist(id: id),
                                                       using: jsonDecoder)
        try Task.checkCancellation()
        return artist
    }
}

