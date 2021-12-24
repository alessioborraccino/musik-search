//
//  ArtistSearchView.swift
//  Musik
//
//  Created by Alessio Borraccino on 04.10.21.
//

import SwiftUI
import MusikCommonUI

struct ArtistSearchView<Model: ArtistSearchViewModelProtocol>: View {

    @Environment(\.dependencyManager) private var dependencyManager: DependencyManager
    @StateObject var model: Model

    var body: some View {
        NavigationView {
            ZStack {
                searchableListView(model: model)
                switch model.viewState {
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
            .alert(isPresented: $model.errorAlertState.isPresented) {
                Alert(title: Text("Error"),
                      message: Text(model.errorAlertState.lastPresentedError?.localizedDescription ?? ""),
                      dismissButton: .default(Text("Ok")))

            }
            .navigationTitle("Artists DB")
        }
    }
}

private extension ArtistSearchView {

    func searchableListView(model: Model) -> some View {
        List {
            if let searchResults = model.viewState.viewModel {
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
        .searchable(text: $model.searchText, prompt: "Type an artist") {
            ForEach(model.textSuggestions, id: \.self) { suggestion in
                Text(suggestion)
                    .foregroundColor(.blue)
                    .searchCompletion(suggestion)
            }
        }
        .onChange(of: model.searchText) { _ in
            model.perform(.search)
        }
        .onSubmit(of: .search) {
            model.perform(.search)
        }
    }
}

struct ArtistSearchView_Previews: PreviewProvider {
    static var previews: some View {
        let model = ArtistSearchViewModel(interactor: ArtistSearchInteractor())
        ArtistSearchView(model: model)
    }
}
