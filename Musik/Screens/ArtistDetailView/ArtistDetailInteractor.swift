//
//  ArtistViewModel.swift
//  Musik
//
//

import Foundation
import MusikNetworking

protocol ArtistDetailInteractorProtocol {
    func fetch(artistId: Int) async throws -> Artist
}

struct ArtistDetailInteractorFactory {
    static var live: ArtistDetailInteractorProtocol {
        ArtistDetailInteractor(repository: MusikRepository())
    }
}

final class ArtistDetailInteractor: ArtistDetailInteractorProtocol {
    private var repository: MusikRepository
    private var currentTask: Task<Artist, Error>?

    init(repository: MusikRepository = MusikRepository()) {
        self.repository = repository
    }

    func fetch(artistId: Int) async throws -> Artist {
        currentTask?.cancel()
        let getArtistTask = Task {
            return try await repository.getArtist(id: artistId)
        }
        currentTask = getArtistTask
        return try await getArtistTask.value
    }
}
