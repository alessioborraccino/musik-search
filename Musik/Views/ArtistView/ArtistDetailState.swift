//
//  ArtistDetailState.swift
//  Musik
//
//

import Foundation

struct ArtistViewState {
    var artistContentState: ArtistContentState
    var errorAlertState: ErrorAlertState
}

enum ArtistiViewAction {
    case load
}

enum ArtistContentState {
    case empty
    case artist(profile: String?,
                name: String?,
                mainImageUrl: String?)

    init(artist: Artist?) {
        if let artist = artist {
            self = .artist(profile: artist.profile,
                           name: artist.name,
                           mainImageUrl: artist.images?.first(where: {$0.type == "primary" })?.url)
        } else {
            self = .empty
        }
    }

    var artistName: String? {
        guard case let .artist(_,name,_) = self else {
            return nil
        }

        return name
    }

    var artistProfile: String? {
        guard case let .artist(profile,_,_) = self else {
            return nil
        }

        return profile
    }

    var artistMainImageUrl: String? {
        guard case let .artist(_,_,url) = self else {
            return nil
        }

        return url
    }
}
