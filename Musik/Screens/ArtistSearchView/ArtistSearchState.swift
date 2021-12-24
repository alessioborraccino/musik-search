//
//  ArtistSearchState.swift
//  Musik
//
//

import Foundation
import MusikNetworking

enum ArtistiSearchAction {
    case search
}

enum ArtistSearchResult {
    case emptySearchText
    case noResultsFound
    case success(_ results: [SearchResult])
    case failureDueToCancellation
    case failureDueTo(_ error: Error)
}
