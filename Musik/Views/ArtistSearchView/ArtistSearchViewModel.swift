//
//  ArtistSearchViewModel.swift
//  Musik
//
//

import Foundation
import SwiftUI

protocol ArtistSearchViewModelProtocol {
    var searchText: String { get }
    var errorAlertState: ErrorAlertState { get }
    var listViewState: ListViewState<[ArtistSearchRowModel]> { get }
}

enum ArtistiSearchAction {
    case search
}

final class ArtistSearchViewModel: ObservableObject, ArtistSearchViewModelProtocol {

    private let interactor: ArtistSearchInteractor

    @Published var searchText = ""
    @Published var errorAlertState: ErrorAlertState = .isNotPresented
    @Published var listViewState: ListViewState<[ArtistSearchRowModel]> = .empty("")
    
    init(interactor: ArtistSearchInteractor) {
        self.interactor = interactor
    }
}

extension ArtistSearchViewModel {

    private static var defaultSuggestions = ["Kylie Minogue", "Britney Spears"]

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

        listViewState = .loading("Getting results...")
        errorAlertState = .isNotPresented

        Task { @MainActor in
            let result = try await interactor.search(for: searchText)

            switch result {
            case .emptySearchText:
                listViewState = .empty("")
                errorAlertState = .isNotPresented
            case .noResultsFound:
                listViewState = .empty("No results found")
                errorAlertState = .isNotPresented
            case .success(let results):
                listViewState = .content(results.map { searchRowModel(from: $0) })
                errorAlertState = .isNotPresented
            case .failureDueToCancellation:
                break
            case .failureDueTo(let error):
                errorAlertState = .isPresented(with: error)
                listViewState = .error("Something went wrong")
            }
        }
    }

    func searchRowModel(from searchResult: SearchResult) -> ArtistSearchRowModel {
        ArtistSearchRowModel(searchResult: searchResult)
    }
}
