//
//  MusikEndpoint.swift
//  Musik
//
//

import Foundation
import ABNetworking

private enum MusikUrl {
    static var base = "api.discogs.com"
    static var headers: [String: String] = [
        "Content-Type": "application/json",
        "Accept": "application/json",
        "User-Agent": "MusikExampleApp/1.0",
        "Authorization": "Discogs token=eBfQhMskdQEWCJwOLvQncsBlKkoQfuDJXMgIEAzO"
    ]
}

enum MusikApiEndpoint {

    struct SearchDatabase: APIEndpoint {
        let baseUrl: String = MusikUrl.base
        let path: String = "database/search"

        private let query: String

        init(query: String) {
            self.query = query
        }

        var queryItems: [URLQueryItem]? {
            [URLQueryItem(name: "q", value: query),
             URLQueryItem(name: "type", value: "artist")]
        }
    }

    struct Artist: APIEndpoint {
        let baseUrl: String = MusikUrl.base
        var path: String { "artists/\(id)" }
        private let id: Int

        init(id: Int) {
            self.id = id
        }
    }
}

extension APIRequest {
    var headers: [String : String]? {
        MusikUrl.headers
    }
}

enum MusikApiRequest {
    struct SearchArtists: APIRequest {
        let method: HTTPMethod = .get
        let endpoint: APIEndpoint

        init(query: String) {
            self.endpoint = MusikApiEndpoint.SearchDatabase(query: query)
        }
    }

    struct GetArtist: APIRequest {

        let method: HTTPMethod = .get
        let endpoint: APIEndpoint

        init(id: Int) {
            self.endpoint = MusikApiEndpoint.Artist(id: id)
        }
    }
}








