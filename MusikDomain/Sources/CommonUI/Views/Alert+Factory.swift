//
//  Alert+Factory.swift
//  
//
//

import Foundation
import SwiftUI

@available(iOS 15, *)
@available(macOS 12, *)
extension Alert {
    public static func simple(for error: Error?) -> Alert {
        let errorDescription = error?.localizedDescription ?? ""
        return Alert(title: Text(String(localized: "Error")),
                     message: Text(errorDescription),
                     dismissButton: .default(Text(String(localized: "Ok"))))
    }
}
