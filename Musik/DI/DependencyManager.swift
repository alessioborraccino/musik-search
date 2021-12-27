//
//  DependencyManager.swift
//  Musik
//

import SwiftUI
import MusikNetworking

final class DependencyManager {
    
    // Shared
    private(set) lazy var musikRepository: MusikRepository = MusikRepository()

    // Interactors
    var artistSearchInteractor: ArtistSearchInteractorProtocol {
        ArtistSearchInteractorFactory.live
    }
    var artistViewInteractor: ArtistDetailInteractorProtocol {
        ArtistDetailInteractorFactory.live
    }
}

struct DependencyManagerKey: EnvironmentKey {
    typealias Value = DependencyManager
    static var defaultValue = DependencyManager()
}

extension EnvironmentValues {
    var dependencyManager: DependencyManager {
        get {
            return self[DependencyManagerKey.self]
        }
        set {
            self[DependencyManagerKey.self] = newValue
        }
    }
}
