//
//  ArtistContentState.swift
//  Musik
//
//

import Foundation

final class ArtistDetailViewModel: ObservableObject {

    @Published var state: ArtistViewState = ArtistViewState(artistContentState: .empty,
                                                            errorAlertState: .isNotPresented)
    private let artistId: Int
    private let interactor: ArtistDetailInteractor

    init(interactor: ArtistDetailInteractor, artistId: Int) {
        self.interactor = interactor
        self.artistId = artistId
    }

    func perform(_ action: ArtistiViewAction) {
        switch action {
        case .load:
            loadArtist(with: artistId)
        }
    }
}

private extension ArtistDetailViewModel {

    func loadArtist(with artistId: Int) {
        Task { @MainActor in
            do {
                let artist = try await interactor.fetch(artistId: artistId)
                state.artistContentState = ArtistContentState(artist: artist)
                state.errorAlertState = .isNotPresented
            } catch {
                if error is CancellationError {
                    state.errorAlertState = .isNotPresented
                } else {
                    state.errorAlertState = .isPresented(with: error)
                }
            }
        }
    }
}
