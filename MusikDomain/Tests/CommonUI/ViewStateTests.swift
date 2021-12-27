//
//  ViewStateTests.swift
//  
//

import Foundation
import XCTest
import MusikCommonUI

enum TestViewModel: Equatable {
    case test
}

final class ViewStateTests: XCTestCase {

    func testViewStateEmpty() {
        let state = ViewState<TestViewModel>.empty("message")
        XCTAssertEqual(state.viewModel, nil)
        XCTAssertEqual(state.message, "message")
    }

    func testViewStateLoading() {
        let state = ViewState<TestViewModel>.loading("message")
        XCTAssertEqual(state.viewModel, nil)
        XCTAssertEqual(state.message, "message")
    }

    func testViewStateErrored() {
        let state = ViewState<TestViewModel>.error("message")
        XCTAssertEqual(state.viewModel, nil)
        XCTAssertEqual(state.message, "message")
    }

    func testViewStateContent() {
        let state = ViewState<TestViewModel>.content(.test)
        XCTAssertEqual(state.viewModel, .test)
        XCTAssertEqual(state.message, nil)
    }

}
