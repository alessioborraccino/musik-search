//
//  SearchResult.swift
//  Musik
//
//

import Foundation

struct SearchResults: Codable {
    let results: [SearchResult]
}

struct SearchResult: Codable, Identifiable, Equatable, Hashable {
    let id: Int
    let style: [String]?
    let thumb: String?
    let title: String
    let formate: [String]?
    let uri: String?
    let label: [String]?
    let year: String?
    let genre: [String]?
    let type: String?
}


