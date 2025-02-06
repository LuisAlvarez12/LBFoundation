//
//  LabelStyleDemo.swift
//  LBFoundation
//
//  Created by Luis Alvarez on 2/5/25.
//
import SwiftUI

public extension PreviewUtils {
    struct LabelStyleDemo<LabelType: LabelStyle>: View {
        var style: LabelType

        public init(style: LabelType) {
            self.style = style
        }

        public var body: some View {
            PreviewUtils.FeaturesContainer {
                VStack {
                    Label("Test", systemImage: "folder")
                    Label("Test", systemImage: "folder").labelStyle(style)
                }
            }
        }
    }
}
