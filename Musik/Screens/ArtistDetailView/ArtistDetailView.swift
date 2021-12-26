//
//  ContentView.swift
//  Musik
//
//

import SwiftUI
import MusikCommonUI

struct ArtistDetailView<Model: ArtistDetailViewModelProtocol>: View {
    
    @StateObject var viewModel: Model
    
    var body: some View {
        VScrollView {
            if case .loading(let message) = viewModel.viewState {
                LoadingView(message: message)
            } else if case .content(let uiModel) = viewModel.viewState {
                VStack(spacing: 8) {
                    Text(viewModel.artistName)
                        .font(.largeTitle)
                    if let imageUrl = uiModel.mainImageUrl {
                        URLImageView(url: imageUrl,
                                     placeholderImageName: "cd-cover")
                            .scaledToFit()
                        Spacer(minLength: 8)
                    }
                    Text(uiModel.profile)
                    Spacer()
                }
                .padding()
            } else if case .error(let message) = viewModel.viewState {
                Text(message)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .onAppear {
            viewModel.perform(.load)
        }
        .alert(isPresented: $viewModel.errorAlertState.isPresented) {
            Alert.simple(for: viewModel.errorAlertState.lastPresentedError)
        }
    }
}

struct ArtistView_Previews: PreviewProvider {
    static var previews: some View {
        let model = ArtistDetailViewModel(interactor: ArtistDetailInteractor(),
                                          artistId: 2000,
                                          artistName: "Fake artist")
        return ArtistDetailView(viewModel: model)
    }
}
