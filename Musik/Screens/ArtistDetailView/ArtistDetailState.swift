//
//  ArtistDetailState.swift
//  Musik
//
//

import Foundation
import MusikNetworking
import MusikCommonUI

enum ArtistiViewAction {
    case load
}

struct ArtistUIModel {
    let profile: String?
    let name: String?
    let mainImageUrl: String?
    
    init(artist: Artist) {
        self.profile = artist.profile
        self.name = artist.name
        self.mainImageUrl = artist.images?.first(where: {$0.type == "primary" })?.url
    }
}
