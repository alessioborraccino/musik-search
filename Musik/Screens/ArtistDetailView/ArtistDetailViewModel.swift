//
//  ArtistContentState.swift
//  Musik
//
//

import Foundation
import MusikCommonUI

protocol ArtistDetailViewModelProtocol: ObservableObject {
    var errorAlertState: ErrorAlertState { get set }
    var viewState: ViewState<ArtistUIModel> { get }
    var artistName: String { get }
    
    func perform(_ action: ArtistiViewAction)
}

final class ArtistDetailViewModel: ArtistDetailViewModelProtocol {

    @Published var errorAlertState: ErrorAlertState = .isNotPresented
    @Published var viewState: ViewState<ArtistUIModel> = .empty("")
    
    let artistName: String
    
    private let artistId: Int
    private let interactor: ArtistDetailInteractorProtocol

    init(interactor: ArtistDetailInteractorProtocol, artistId: Int, artistName: String) {
        self.interactor = interactor
        self.artistId = artistId
        self.artistName = artistName
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
        viewState = .loading("Getting artist info")
        Task { @MainActor in
            do {
                let artist = try await interactor.fetch(artistId: artistId)
                viewState = .content(ArtistUIModel(artist: artist))
                errorAlertState = .isNotPresented
            } catch {
                if error is CancellationError {
                    errorAlertState = .isNotPresented
                } else {
                    viewState = .error("Could not get artist info")
                    errorAlertState = .isPresented(with: error)
                }
            }
        }
    }
}
