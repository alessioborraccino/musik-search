//
//  MusikRepositoryTests.swift
//  
//
//  Created by Alessio Borraccino on 26.12.21.
//

import Foundation
import XCTest
import ABNetworking
import MusikNetworking

final class MusikRepositoryTests: XCTestCase {

    private let musikRepository = MusikRepository()

    private static let identifier = 1
    private static let searchQuery = "hello"

    override func setUpWithError() throws {
        Stubber.default.start()
    }

    override func tearDownWithError() throws {
        Stubber.default.stop()
    }
}

extension MusikRepositoryTests {

    func testGetArtistSuccessful() async throws {
        try Stubber.default.stubGetArtist(identifier: MusikRepositoryTests.identifier)
        let artist = try await musikRepository.getArtist(id: MusikRepositoryTests.identifier)
        XCTAssertEqual(artist.name, "name")
        XCTAssertEqual(artist.id,  MusikRepositoryTests.identifier)
        XCTAssertEqual(artist.profile, "profile")
        XCTAssertEqual(artist.images?.first?.url, "url")
        XCTAssertEqual(artist.images?.first?.type, "type")
        XCTAssertEqual(artist.images?.first?.height, 30)
        XCTAssertEqual(artist.images?.first?.width, 30)
    }

    func testSearchSuccessful() async throws {
        try Stubber.default.stubSearchQuery(MusikRepositoryTests.searchQuery)
        let searchResults = try await musikRepository.search(query: MusikRepositoryTests.searchQuery)
        XCTAssertEqual(searchResults.count, 2)
        XCTAssertEqual(searchResults.first?.id, 1)
        XCTAssertEqual(searchResults.first?.title, MusikRepositoryTests.searchQuery + " M")
        XCTAssertEqual(searchResults.first?.year, "1986")
        XCTAssertEqual(searchResults.first?.genre, ["pop"])
        XCTAssertEqual(searchResults.last?.id, 2)
        XCTAssertEqual(searchResults.last?.title, MusikRepositoryTests.searchQuery + " J")
        XCTAssertEqual(searchResults.last?.year, "1990")
        XCTAssertEqual(searchResults.last?.genre, ["rock"])
    }

    func testGetArtistFailing() async throws {
        try Stubber.default.stubGetArtist(identifier: MusikRepositoryTests.identifier, isSuccessful: false)
        do {
            let _ = try await musikRepository.getArtist(id: MusikRepositoryTests.identifier)
        } catch {
            guard case ABNetworkingError.urlSessionError = error else {
                XCTFail()
                return
            }
        }
    }

    func testSearchFailing() async throws {
        try Stubber.default.stubSearchQuery(MusikRepositoryTests.searchQuery, isSuccessful: false)
        do {
            let _ = try await musikRepository.search(query: MusikRepositoryTests.searchQuery)
        } catch {
            guard case ABNetworkingError.urlSessionError = error else {
                XCTFail()
                return
            }
        }
    }

    func testGetArtistCancel() async throws {
        try Stubber.default.stubGetArtist(identifier: MusikRepositoryTests.identifier, isSuccessful: false)
        do {
            let handle = Task {
                try await musikRepository.getArtist(id: MusikRepositoryTests.identifier)
            }
            handle.cancel()
            _ = try await handle.value
        } catch {
            XCTAssert(error is CancellationError)

        }
    }

    func testSearchCancel() async throws {
        try Stubber.default.stubSearchQuery(MusikRepositoryTests.searchQuery, isSuccessful: false)
        do {
            let handle = Task {
                try await musikRepository.search(query: MusikRepositoryTests.searchQuery)
            }
            handle.cancel()
            _ = try await handle.value
        } catch {
            XCTAssert(error is CancellationError)
        }
    }
}
