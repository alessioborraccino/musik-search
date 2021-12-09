//
//  ArtistSearchView.swift
//  Musik
//
//  Created by Alessio Borraccino on 04.10.21.
//

import SwiftUI

struct ArtistSearchView: View {

    @Environment(\.dependencyManager) private var dependencyManager: DependencyManager
    @StateObject var model: ArtistSearchViewModel

    var body: some View {
        NavigationView {
            ZStack {
                searchableListView(model: model)

                switch model.listViewState {
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
                      message: Text(model.errorAlertState.error?.localizedDescription ?? ""),
                      dismissButton: .default(Text("Ok")))

            }
            .navigationTitle("Artists DB")
        }
    }
}

private extension ArtistSearchView {

    func searchableListView(model: ArtistSearchViewModel) -> some View {
        List {
            if let searchResults = model.listViewState.viewModel {
                ForEach(searchResults, id: \.id) { rowModel in
                    let viewModel = ArtistDetailViewModel(interactor: dependencyManager.artistViewInteractor,
                                                          artistId: rowModel.id)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model = ArtistSearchViewModel(interactor: ArtistSearchInteractor())
        ArtistSearchView(model: model)
    }
}
