//
//  ButtonStyleDemo.swift
//  LBFoundation
//
//  Created by Luis Alvarez on 2/5/25.
//
import SwiftUI

extension PreviewUtils {
    struct ButtonStyleDemo<ButtonType: ButtonStyle>: View {
        var style: ButtonType

        var body: some View {
            PreviewUtils.FeaturesContainer {
                VStack {
                    Button("Hello", systemImage: "folder", action: {})
                    Button("Hello", systemImage: "folder", action: {}).buttonStyle(style)
                }
            }
        }
    }
}
