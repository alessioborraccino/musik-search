//
//  DependencyManager.swift
//  Musik
//


import SwiftUI
import ABNetworking

final class DependencyManager {
    
    // Shared
    private(set) lazy var apiClient: JsonApiClient = JsonApiClient()
    private(set) lazy var musikRepository: MusikRepository = MusikRepository(client: apiClient)

    // Interactors
    private(set) lazy var artistSearchInteractor = ArtistSearchInteractor(repository: musikRepository)
    private(set) lazy var artistViewInteractor = ArtistDetailInteractor(repository: musikRepository)
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
