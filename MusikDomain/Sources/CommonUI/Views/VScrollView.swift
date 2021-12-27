//
//  VScrollView
//  
//
//

import SwiftUI

public struct VScrollView<Content>: View where Content: View {
    
    @ViewBuilder let content: Content
    
    public init(@ViewBuilder contentBuilder: () -> Content) {
        self.content = contentBuilder()
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                content
                    .frame(width: geometry.size.width)
                    .frame(minHeight: geometry.size.height)
            }
        }
    }
}
