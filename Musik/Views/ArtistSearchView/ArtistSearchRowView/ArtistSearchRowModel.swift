//
//  ArtistSearchRowViewModel.swift
//  Musik
//
//  Created by Alessio Borraccino on 12.11.21.
//

import SwiftUI

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
