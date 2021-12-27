//
//  LoadingView.swift
//  Musik
//
//

import SwiftUI

@available(macOS 11.0, *)
@available(iOS 14, *)
public struct LoadingView: View {
    public let message: String
    
    public init(message: String) {
        self.message = message 
    }

    public var body: some View {
        HStack {
            Spacer()
            VStack {
                Text(message).padding()
                ProgressView().padding()
            }
            Spacer()
        }
    }
}
