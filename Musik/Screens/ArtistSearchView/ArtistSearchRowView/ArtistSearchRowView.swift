//
//  ArtistSearchRowView.swift
//  Musik
//
//

import Foundation
import SwiftUI
import MusikCommonUI

struct ArtistSearchRowView: View {

    private let rowModel: ArtistSearchRowModel

    init(rowModel: ArtistSearchRowModel) {
        self.rowModel = rowModel
    }

    var body: some View {
        HStack {
            URLImageView(url: rowModel.thumbUrl,
                         placeholderImageName: "cd-cover")
                .frame(width: 50, height: 50)
            Text(rowModel.title)
        }
    }
}
