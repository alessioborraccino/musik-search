//
//  ArtistSearchRowViewModel.swift
//  Musik
//
//

import SwiftUI
import MusikNetworking

struct ArtistSearchRowModel: Identifiable {

    let thumbUrl: String?
    let title: String
    let id: Int

    init(searchResult: SearchResult) {
        self.id = searchResult.id
        self.thumbUrl = searchResult.thumb
        self.title = searchResult.title
    }
}
