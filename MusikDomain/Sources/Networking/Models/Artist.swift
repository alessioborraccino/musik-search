//
//  Artist.swift
//  Musik
//
//

import Foundation

public struct Artist: Codable, Identifiable, Equatable, Hashable {
    public let id: Int
    public let name: String
    public let profile: String?
    public let urls: [String]?
    public let images: [APIImage]?

    init(id: Int, name: String, profile: String? = nil, urls: [String]? = [], images: [APIImage]? = []) {
        self.id = id
        self.name = name
        self.profile = profile
        self.urls = urls
        self.images = images
    }
}

public struct APIImage: Codable, Equatable, Hashable {

    enum CodingKeys: String, CodingKey {
        case height
        case width
        case url = "resource_url"
        case type
    }

    public let height: Double
    public let width: Double
    public let url: String
    public let type: String

    init(height: Double, width: Double, url: String, type: String) {
        self.height = height
        self.width = width
        self.url = url
        self.type = type
    }
}

