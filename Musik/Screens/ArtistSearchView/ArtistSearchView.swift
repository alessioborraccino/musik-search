//
//  ArtistSearchView.swift
//  Musik
//
//  Created by Alessio Borraccino on 04.10.21.
//

import SwiftUI
import MusikCommonUI

struct ArtistSearchView<ViewModel: ArtistSearchViewModelProtocol>: View {

    @Environment(\.dependencyManager) private var dependencyManager: DependencyManager
    @StateObject var viewModel: ViewModel

    var body: some View {
        NavigationView {
            ZStack {
                searchableListView(viewModel: viewModel)
                switch viewModel.viewState {
                case .content(_):
                    EmptyView()
                case .empty(let message):
                    Text(message)
                case .loading(let message):
                    LoadingView(message: message)
                case .error(let message):
                    Text(message)
                }
            }
            .alert(isPresented: $viewModel.errorAlertState.isPresented) {
                Alert.simple(for: viewModel.errorAlertState.lastPresentedError)
            }
            .navigationTitle(viewModel.title)
        }
    }
}

private extension ArtistSearchView {

    func searchableListView(viewModel: ViewModel) -> some View {
        List {
            if let searchResults = viewModel.viewState.viewModel {
                ForEach(searchResults, id: \.id) { rowModel in
                    let viewModel = ArtistDetailViewModel(interactor: dependencyManager.artistViewInteractor,
                                                          artistId: rowModel.id,
                                                          artistName: rowModel.title)
                    let destination = ArtistDetailView(viewModel: viewModel)
                    NavigationLink(destination: destination) {
                        ArtistSearchRowView(rowModel: rowModel)
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .searchable(text: $viewModel.searchText, prompt: viewModel.searchPrompt) {
            ForEach(viewModel.textSuggestions, id: \.self) { suggestion in
                Text(suggestion)
                    .foregroundColor(.blue)
                    .searchCompletion(suggestion)
            }
        }
        .onChange(of: viewModel.searchText) { _ in
            viewModel.perform(.search)
        }
        .onSubmit(of: .search) {
            viewModel.perform(.search)
        }
    }
}

struct ArtistSearchView_Previews: PreviewProvider {
    static var previews: some View {
        let model = ArtistSearchViewModel(interactor: ArtistSearchInteractor())
        ArtistSearchView(viewModel: model)
    }
}
