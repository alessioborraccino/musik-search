//
//  File.swift
//  
//
//  Created by Alessio Borraccino on 25.12.21.
//

import Foundation
import SwiftUI

extension Alert {
    public static func simple(for error: Error?) -> Alert {
        let errorDescription = error?.localizedDescription ?? ""
        return Alert(title: Text(String(localized: "Error")),
                     message: Text(errorDescription),
                     dismissButton: .default(Text(String(localized: "Ok"))))
    }
}
