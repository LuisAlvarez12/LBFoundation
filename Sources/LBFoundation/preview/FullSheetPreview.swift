//
//  FullSheetPreview.swift
//  LBFoundation
//
//  Created by Luis Alvarez on 2/4/25.
//

import SwiftUI

public extension PreviewUtils {
    
    public struct FullSheetPreview<Content>: View where Content: View {
        @ViewBuilder var content: () -> Content
        
        public init(content: @escaping () -> Content) {
            self.content = content
        }
        
        public var body: some View {
            VStack {
                Color.clear
            }.containerRelativeFrame([.horizontal, .vertical]).fullScreenCover(isPresented: .constant(true)) {
                content()
            }
        }
    }
}
