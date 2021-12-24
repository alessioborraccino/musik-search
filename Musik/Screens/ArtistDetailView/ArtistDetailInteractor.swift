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

final class ArtistDetailInteractor: ArtistDetailInteractorProtocol {
    private var repository: MusikRepository
    private var currentTask: Task<Artist, Error>?

    init(repository: MusikRepository = MusikRepository()) {
        self.repository = repository
    }
}

extension ArtistDetailInteractor {

    func fetch(artistId: Int) async throws -> Artist {
        currentTask?.cancel()
        let getArtistTask = Task {
            return try await repository.getArtist(id: artistId)
        }
        currentTask = getArtistTask
        return try await getArtistTask.value
    }
}
