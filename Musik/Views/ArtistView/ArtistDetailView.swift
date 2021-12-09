//
//  ContentView.swift
//  Musik
//
//

import SwiftUI

struct ArtistDetailView: View {

    @StateObject var viewModel: ArtistDetailViewModel

    var body: some View {
        ScrollView {
            VStack {
                URLImageView(url: viewModel.state.artistContentState.artistMainImageUrl,
                             placeholderImageName: "cd-cover")
                    .scaledToFit()
                Spacer(minLength: 12)
                Text(viewModel.state.artistContentState.artistProfile ?? "")
            }
            .padding()
        }
        .navigationTitle(viewModel.state.artistContentState.artistName ?? "")
        .onAppear {
            viewModel.perform(.load)
        }
        .alert(isPresented: $viewModel.state.errorAlertState.isPresented) {
            Alert(title: Text("Error"),
                  message: Text(viewModel.state.errorAlertState.errorText),
                  dismissButton: .default(Text("Ok")))
        }
    }
}

struct ArtistView_Previews: PreviewProvider {
    static var previews: some View {
        let model = ArtistDetailViewModel(interactor: ArtistDetailInteractor(),
                                          artistId: 2000)
        return ArtistDetailView(viewModel: model)
    }
}
