//
//  File.swift
//
//
//  Created by Alessio Borraccino on 24.12.21.
//

import Foundation
import Hippolyte
@testable import MusikNetworking

final class Stubber {
    
    static let `default` = Stubber()
    
    func start() {
        Hippolyte.shared.start()
    }
    
    func stop() {
        Hippolyte.shared.stop()
    }
}

extension Stubber {
    func stubGetArtist(identifier: Int, isSuccessful: Bool = true) throws {
        
        let responseGetArtist: StubResponse
        
        if isSuccessful {
            let artist = Artist(id: identifier,
                                name: "name",
                                profile: "profile",
                                urls: [],
                                images: [])
            
            let artistData = try JSONEncoder().encode(artist)
            responseGetArtist =
            StubResponse.Builder()
                .stubResponse(withStatusCode: 200)
                .addBody(artistData)
                .build()
        } else {
            responseGetArtist =
            StubResponse.Builder()
                .stubResponse(withStatusCode: 404)
                .build()
        }
        
        let requestGetArtist = StubRequest.Builder()
            .stubRequest(withMethod: .GET, url: MusikApiEndpoint.Artist(id: identifier).url!)
            .addResponse(responseGetArtist)
            .build()
        
        Hippolyte.shared.add(stubbedRequest: requestGetArtist)
    }
    
    func stubSearchQuery(_ searchQuery: String, isSuccessful: Bool = true) throws {
        
        let responseSearch: StubResponse
        
        if isSuccessful {
            let searchResultOne = SearchResult(id: 1, style: nil, thumb: nil, title: "\(searchQuery) M", formate: nil, uri: nil, label: nil, year: "1986", genre: ["pop"], type: nil)
            let searchResultTwo = SearchResult(id: 2, style: nil, thumb: nil, title: "\(searchQuery) J", formate: nil, uri: nil, label: nil, year: "1990", genre: ["rock"], type: nil)
            let results = [searchResultOne, searchResultTwo]
            let searchResults = SearchResults(results: results)
            let resultsData = try JSONEncoder().encode(searchResults)
            
            responseSearch = StubResponse.Builder()
                .stubResponse(withStatusCode: 200)
                .addBody(resultsData)
                .build()
        } else {
            responseSearch =
            StubResponse.Builder()
                .stubResponse(withStatusCode: 404)
                .build()
        }
        let requestSearch = StubRequest.Builder()
            .stubRequest(withMethod: .GET, url: MusikApiEndpoint.SearchDatabase(query: searchQuery).url!)
            .addResponse(responseSearch)
            .build()
        Hippolyte.shared.add(stubbedRequest: requestSearch)
    }
}
