//
//  ErrorState.swift
//  Musik
//
//

import Foundation

struct ErrorAlertState: Equatable {
    var presentationState: ErrorAlertPresentationState = .isNotPresented {
        didSet {
            isPresented = presentationState.boolValue
        }
    }
    var isPresented: Bool = false
}

extension ErrorAlertState {
    static var isNotPresented = ErrorAlertState()
    static func isPresented(with error: Error) -> ErrorAlertState {
        ErrorAlertState(presentationState: .isPresented(error), isPresented: true)
    }
    var error: Error? {
        guard case let .isPresented(error) = presentationState else {
            return nil
        }

        return error
    }

    var errorText: String {
        error?.localizedDescription ?? ""
    }
}

enum ErrorAlertPresentationState: Equatable {
    case isPresented(Error)
    case isNotPresented

    var boolValue: Bool {
        switch self {
        case .isPresented(_):
            return true
        case .isNotPresented:
            return false
        }
    }

    static func == (lhs: ErrorAlertPresentationState, rhs: ErrorAlertPresentationState) -> Bool {
        switch (lhs, rhs) {
        case (.isPresented(let errorLhs), .isPresented(let errorRhs)):
            return errorLhs.localizedDescription == errorRhs.localizedDescription
        case (.isNotPresented, .isNotPresented):
            return true
        default:
            return false
        }
    }
}
