//
//  PrimaryButtonStyle.swift
//  LBFoundation
//
//  Created by Luis Alvarez on 2/5/25.
//

import SwiftUI

public extension ButtonStyle where Self == PrimaryStyle {
    static var lbPrimary: PrimaryStyle { .init() }
}

public struct PrimaryStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(currentAppTheme.primary)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal)
    }
}

#Preview {
    PreviewUtils.ButtonStyleDemo<PrimaryStyle>(style: .lbPrimary)
}
