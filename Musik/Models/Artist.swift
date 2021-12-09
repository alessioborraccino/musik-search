//
//  Artist.swift
//  Musik
//
//

import Foundation

struct Artist: Codable, Identifiable, Equatable, Hashable {
    let id: Int
    let name: String
    let profile: String?
    let urls: [String]?
    let images: [APIImage]?
}

struct APIImage: Codable, Equatable, Hashable {

    enum CodingKeys: String, CodingKey {
        case height
        case width
        case url = "resource_url"
        case type
    }

    let height: Double
    let width: Double
    let url: String
    let type: String
}

