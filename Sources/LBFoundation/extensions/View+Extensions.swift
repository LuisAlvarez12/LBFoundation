//
//  View+Extensions.swift
//  LBFoundation
//
//  Created by Luis Alvarez on 2/4/25.
//
import SwiftUI

public extension View {
    
    public func previewDelay(_ time: Double = 0.5, action: @escaping () -> Void) -> some View {
        return task {
            await delay(time)
            withAnimation(.bouncy) {
                action()
            }
        }
    }
    
    public func padding(_ horizontal: CGFloat, _ vertical: CGFloat) -> some View {
        self.padding(.horizontal, horizontal).padding(.vertical, vertical)
    }
    
    public func padding(leading: CGFloat = 0, top: CGFloat = 0, trailing: CGFloat = 0, bottom: CGFloat = 0) -> some View {
        self
            .padding(.leading, leading)
            .padding(.top, top)
            .padding(.trailing, trailing)
            .padding(.bottom, bottom)
    }
    
    public func widthAligned(_ alignment: Alignment = .leading) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
    
    public func heightAligned(_ alignment: Alignment = .top) -> some View {
        self.frame(maxHeight: .infinity, alignment: alignment)
    }
    
    public func fullFrame() -> some View {
        self.containerRelativeFrame([.horizontal, .vertical])
    }
    
    public func squareFrame(_ size: CGFloat) -> some View {
        self.frame(width: size, height: size)
    }
}
