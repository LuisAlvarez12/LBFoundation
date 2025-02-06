//
//  View+Extensions.swift
//  LBFoundation
//
//  Created by Luis Alvarez on 2/4/25.
//
import SwiftUI

public extension View {
    func previewDelay(_ time: Double = 0.5, action: @escaping () -> Void) -> some View {
        return task {
            await delay(time)
            withAnimation(.bouncy) {
                action()
            }
        }
    }

    func padding(_ horizontal: CGFloat, _ vertical: CGFloat) -> some View {
        padding(.horizontal, horizontal).padding(.vertical, vertical)
    }

    func padding(leading: CGFloat = 0, top: CGFloat = 0, trailing: CGFloat = 0, bottom: CGFloat = 0) -> some View {
        padding(.leading, leading)
            .padding(.top, top)
            .padding(.trailing, trailing)
            .padding(.bottom, bottom)
    }

    func widthAligned(_ alignment: Alignment = .leading) -> some View {
        frame(maxWidth: .infinity, alignment: alignment)
    }

    func heightAligned(_ alignment: Alignment = .top) -> some View {
        frame(maxHeight: .infinity, alignment: alignment)
    }

    func fullFrame() -> some View {
        containerRelativeFrame([.horizontal, .vertical])
    }

    func squareFrame(_ size: CGFloat) -> some View {
        frame(width: size, height: size)
    }
}
