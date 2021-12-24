//
//  URLImageView.swift
//  Musik
//
//

import Foundation
import SwiftUI

public struct URLImageView: View {

    private var url: URL?
    private var placeholderImageName: String?

    public init(url: String?, placeholderImageName: String? = nil) {
        if let url = url {
            self.url = URL(string: url)
        } else {
            self.url = nil
        }

        self.placeholderImageName = placeholderImageName
    }

    public var body: some View {

        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image.resizable()
            case .failure(_), .empty:
                placeholderView
            @unknown default:
                placeholderView
            }
        }
    }
}

extension URLImageView {
    private var loadingView: some View {
        ProgressView()
    }

    private var placeholderView: some View {
        if let placeholderImageName = placeholderImageName {
            return Image(uiImage: UIImage(named: placeholderImageName)!)
                .resizable()
        } else {
            return Image(decorative: "Empty")
        }
    }
}