//
//  ArtistViewModel.swift
//  Musik
//
//  Created by Alessio Borraccino on 06.10.21.
//

import Foundation

enum ArtistSearchResult {
    case emptySearchText
    case noResultsFound
    case success(_ results: [SearchResult])
    case failureDueToCancellation
    case failureDueTo(_ error: Error)
}

final class ArtistSearchInteractor {
    private var repository: MusikRepository
    private var currentTask: Task<ArtistSearchResult, Error>?

    init(repository: MusikRepository = MusikRepository()) {
        self.repository = repository
    }
}

extension ArtistSearchInteractor {

    func search(for searchText: String) async throws -> ArtistSearchResult {
        let text = searchText
        guard !text.isEmpty else {
            return .emptySearchText
        }

        currentTask?.cancel()
        let searchTask: Task<ArtistSearchResult, Error> = Task {
            do {
                let searchResults = try await repository.search(query: text)
                if searchResults.isEmpty {
                    return .noResultsFound
                } else {
                    return .success(searchResults)
                }
            } catch let error {
                if error is CancellationError {
                    return .failureDueToCancellation
                } else {
                    return .failureDueTo(error)
                }
            }
        }

        currentTask = searchTask
        return try await searchTask.value
    }
}
