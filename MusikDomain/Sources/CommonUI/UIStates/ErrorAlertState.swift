//
//  ErrorState.swift
//  Musik
//
//

import Foundation

public struct ErrorAlertState {
    public var isPresented: Bool = false
    public var lastPresentedError: Error? = nil
}

extension ErrorAlertState {
    public static var isNotPresented = ErrorAlertState()
    public static func isPresented(with error: Error) -> ErrorAlertState {
        ErrorAlertState(isPresented: true, lastPresentedError: error)
    }
}

extension ErrorAlertState {
    public var errorText: String {
        lastPresentedError?.localizedDescription ?? ""
    }
}
