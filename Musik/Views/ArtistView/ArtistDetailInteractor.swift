//
//  ArtistViewModel.swift
//  Musik
//
//

import Foundation

final class ArtistDetailInteractor {
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
