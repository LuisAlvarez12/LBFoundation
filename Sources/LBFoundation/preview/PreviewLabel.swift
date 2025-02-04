//
//  PreviewLabel.swift
//  LBFoundation
//
//  Created by Luis Alvarez on 2/4/25.
//

import SwiftUI

/// A view that wraps content in a labeled preview container
public struct PreviewLabel<Content>: View where Content: View {
    /// The text to display as the preview label
    public let previewText: String

    /// The content to display in the preview container
    @ViewBuilder var content: () -> Content
    var cornerRadius: CGFloat = 16

    /// Creates a new preview label view
    /// - Parameters:
    ///   - previewText: The text to display as the preview label
    ///   - content: A closure that creates the content to display
    public init(_ previewText: String,
                cornerRadius: CGFloat = 16,
                content: @escaping () -> Content) {
        self.previewText = previewText
        self.content = content
        self.cornerRadius = cornerRadius
    }

    /// The body of the preview label view
    public var body: some View {
        VStack {
            Text(previewText)
                .font(.title2)
                .bold()
            VStack {
                content()
            }
            .cornerRadius(cornerRadius)
            .padding(cornerRadius)
                .background(RoundedRectangle(cornerRadius: cornerRadius * 2).fill(Material.thick))
                .padding(16, 4)
       
        }
    }
}

#Preview {
    PreviewLabel("This is a Red View", content: {
        VStack{
            Color.red
        }
    })
}
