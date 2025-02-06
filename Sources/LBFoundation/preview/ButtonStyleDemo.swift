//
//  ButtonStyleDemo.swift
//  LBFoundation
//
//  Created by Luis Alvarez on 2/5/25.
//
import SwiftUI

public extension PreviewUtils {
    
    public struct ButtonStyleDemo<ButtonType: ButtonStyle>: View {
        var style: ButtonType
        
        public init(style: ButtonType) {
            self.style = style
        }

        public var body: some View {
            PreviewUtils.FeaturesContainer {
                VStack {
                    Button("Hello", systemImage: "folder", action: {})
                    Button("Hello", systemImage: "folder", action: {}).buttonStyle(style)
                }
            }
        }
    }
}
