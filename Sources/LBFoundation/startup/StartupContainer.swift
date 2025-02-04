//
//  Bootstrapper.swift
//  LBFoundation
//
//  Created by Luis Alvarez on 2/3/25.
//

import SwiftUI

public struct StartupContainer<Content: View>: View {
    
    var startupTasks: () async -> Void
    
    @ViewBuilder var loading: () -> Content
    @ViewBuilder var content: () -> Content
    
    @State private var startupComplete = false
    
    public init(startupTasks: @escaping () async -> Void, loading: @escaping () -> Content, content: @escaping () -> Content) {
        self.startupTasks = startupTasks
        self.loading = loading
        self.content = content
    }
    
    public var body: some View {
        ZStack {
            if startupComplete {
                content()
            } else {
                loading()
            }
        }.containerRelativeFrame([.horizontal, .vertical]).task {
            await startupTasks()
            withAnimation {
                startupComplete = true
            }
        }
    }
}

#Preview {
    StartupContainer(startupTasks: {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
    }, loading: {
        Color.red
    }, content: {
        Color.blue
    })
}
