//
//  SearchResult.swift
//  Musik
//
//

import Foundation

public struct SearchResults: Codable {
    public let results: [SearchResult]
}

public struct SearchResult: Codable, Identifiable, Equatable, Hashable {
    public let id: Int
    public let style: [String]?
    public let thumb: String?
    public let title: String
    public let format: [String]?
    public let uri: String?
    public let label: [String]?
    public let year: String?
    public let genre: [String]?
    public let type: String?

    init(id: Int, title: String, thumb: String?) {
        self.id = id
        self.title = title
        self.thumb = thumb
        self.style = nil
        self.format = nil
        self.uri = nil
        self.label = nil
        self.year = nil
        self.genre = nil
        self.type = nil
    }
}


