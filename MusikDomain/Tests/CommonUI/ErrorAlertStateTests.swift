//
//  ErrorAlertStateTests.swift
//  
//
//  Created by Alessio Borraccino on 27.12.21.
//

import Foundation
import XCTest
import MusikCommonUI

enum TestError: Error, Equatable {
    case test
}

final class ErrorAlertStateTests: XCTestCase {

    func testErrorAlertStatePresented() {
        let error = TestError.test
        let state = ErrorAlertState.isPresented(with: error)
        XCTAssertEqual(state.errorText, TestError.test.localizedDescription)
        XCTAssertEqual(state.lastPresentedError as! TestError, TestError.test)
    }

    func testErrorAlertStateNotPresented() {
        let state = ErrorAlertState.isNotPresented
        XCTAssertEqual(state.errorText, "")
        XCTAssertNil(state.lastPresentedError)
    }
}
