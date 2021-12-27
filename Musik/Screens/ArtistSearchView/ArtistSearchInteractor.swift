//
//  ArtistViewModel.swift
//  Musik
//
//

import Foundation
import MusikNetworking

protocol ArtistSearchInteractorProtocol {
    func search(for searchText: String) async throws -> ArtistSearchResult
}

struct ArtistSearchInteractorFactory {
    static var live: ArtistSearchInteractorProtocol {
        ArtistSearchInteractor(repository: MusikRepository())
    }
}

final class ArtistSearchInteractor: ArtistSearchInteractorProtocol {
    
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
