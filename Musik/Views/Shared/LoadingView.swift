//
//  LoadingView.swift
//  Musik
//
//

import SwiftUI

struct LoadingView {
    let message: String
}

extension LoadingView: View {
    var body: some View {
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
