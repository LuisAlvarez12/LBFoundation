//
//  SheetPreview.swift
//  LBFoundation
//
//  Created by Luis Alvarez on 2/3/25.
//
import SwiftUI

public extension PreviewUtils {
    
    public struct SheetPreview<Content>: View where Content: View {
        @ViewBuilder var content: () -> Content
        
        public init(content: @escaping () -> Content) {
            self.content = content
        }
        
        public var body: some View {
            VStack {
                Color.clear
            }.containerRelativeFrame([.horizontal, .vertical]).sheet(isPresented: .constant(true)) {
                content()
                    .withLanguage(.English)
            }
        }
    }
}



