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
    public let formate: [String]?
    public let uri: String?
    public let label: [String]?
    public let year: String?
    public let genre: [String]?
    public let type: String?
}


