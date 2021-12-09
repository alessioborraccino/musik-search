//
//  MusikApp.swift
//  Musik
//
//  Created by Alessio Borraccino on 04.10.21.
//

import SwiftUI

@main
struct MusikApp: App {

    @Environment(\.dependencyManager) private var dependencyManager: DependencyManager

    var body: some Scene {
        WindowGroup {
            let model = ArtistSearchViewModel(interactor: dependencyManager.artistSearchInteractor)
            ArtistSearchView(model: model)
        }
    }
}
