//
//  ArtistDetailInteractorMock.swift
//  MusikTests
//
//  Created by Alessio Borraccino on 27.12.21.
//

import Foundation
@testable import Music_Search
@testable import MusikNetworking

extension ArtistDetailInteractorFactory {
    static var mock: ArtistDetailInteractorProtocol {
        ArtistDetailInteractorMock()
    }
}

final class ArtistDetailInteractorMock: ArtistDetailInteractorProtocol {
    func fetch(artistId: Int) async throws -> Artist {
        return Artist(id: artistId, name: "Kylie", profile: "profile", urls: nil, images: nil)
    }
}
