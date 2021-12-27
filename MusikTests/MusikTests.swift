//
//  MusikTests.swift
//  MusikTests
//
//  Created by Alessio Borraccino on 04.10.21.
//

import XCTest
import SnapshotTesting
@testable import Music_Search

class MusikTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDetailStartingAppearance() {
        let interactor = ArtistDetailInteractorFactory.mock
        let model = ArtistDetailViewModel(interactor: interactor,
                                          artistId: 1,
                                          artistName: "Kylie")
        let artistDetailView = ArtistDetailView(viewModel: model)
        assertSnapshot(matching: artistDetailView, as: .image)
    }

    func testSearchStartingAppearance() {
        let interactor = ArtistSearchInteractorFactory.mock
        let model = ArtistSearchViewModel(interactor: interactor)
        let artistSearchView = ArtistSearchView(model: model)
        assertSnapshot(matching: artistSearchView, as: .image)
    }
}
