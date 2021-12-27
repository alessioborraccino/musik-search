//
//  ArtistSearchViewModel.swift
//  Musik
//
//

import Foundation
import SwiftUI
import MusikNetworking
import MusikCommonUI

protocol ArtistSearchViewModelProtocol: ObservableObject {
    var viewState: ViewState<[ArtistSearchRowModel]> { get }
    var errorAlertState: ErrorAlertState { get set }
    var searchText: String { get set }
    var textSuggestions: [String] { get }
    var searchPrompt: String { get }
    var title: String { get }

    func perform(_ action: ArtistiSearchAction)
}

final class ArtistSearchViewModel: ArtistSearchViewModelProtocol {

    private let interactor: ArtistSearchInteractorProtocol

    @Published var searchText = ""
    @Published var errorAlertState: ErrorAlertState = .isNotPresented
    @Published var viewState: ViewState<[ArtistSearchRowModel]> = .empty("")
    
    init(interactor: ArtistSearchInteractorProtocol) {
        self.interactor = interactor
    }
}

extension ArtistSearchViewModel {

    private static var defaultSuggestions = ["Kylie Minogue", "Britney Spears"]

    var title: String {
        String(localized: "Artists DB")
    }
    
    var searchPrompt: String {
        String(localized: "Type an artist")
    }
    
    var textSuggestions: [String] {
        guard searchText.isEmpty else {
            return []
        }

        return ArtistSearchViewModel.defaultSuggestions
    }

    func perform(_ action: ArtistiSearchAction) {
        switch action {
        case .search:
            search()
        }
    }
}

private extension ArtistSearchViewModel {

    func search() {

        viewState = .loading(String(localized:"Getting results..."))
        errorAlertState = .isNotPresented

        Task { @MainActor in
            let result = try await interactor.search(for: searchText)

            switch result {
            case .emptySearchText:
                viewState = .empty("")
                errorAlertState = .isNotPresented
            case .noResultsFound:
                viewState = .empty(String(localized:"No results found"))
                errorAlertState = .isNotPresented
            case .success(let results):
                viewState = .content(results.map { searchRowModel(from: $0) })
                errorAlertState = .isNotPresented
            case .failureDueTo(let error):
                viewState = .error(String(localized:"Something went wrong"))
                errorAlertState = .isPresented(with: error)
            case .failureDueToCancellation:
                break
            }
        }
    }

    func searchRowModel(from searchResult: SearchResult) -> ArtistSearchRowModel {
        ArtistSearchRowModel(searchResult: searchResult)
    }
}
