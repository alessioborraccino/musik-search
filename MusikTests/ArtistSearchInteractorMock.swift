//
//  ArtistDetailInteractorMock.swift
//  MusikTests
//
//  Created by Alessio Borraccino on 27.12.21.
//

import Foundation
@testable import Music_Search
@testable import MusikNetworking

extension ArtistSearchInteractorFactory {
    static var mock: ArtistSearchInteractorProtocol {
        ArtistSearchInteractorMock()
    }
}

final class ArtistSearchInteractorMock: ArtistSearchInteractorProtocol {
    func search(for searchText: String) async throws -> ArtistSearchResult {
        return ArtistSearchResult.success([
            SearchResult(id: 1, title: searchText, thumb: nil)
        ])
    }
}
