//
//  LoadingView.swift
//  Musik
//
//

import SwiftUI

public struct LoadingView {
    public let message: String
    
    public init(message: String) {
        self.message = message 
    }
}

extension LoadingView: View {
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
