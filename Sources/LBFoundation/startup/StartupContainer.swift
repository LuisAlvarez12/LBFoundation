//
//  Bootstrapper.swift
//  LBFoundation
//
//  Created by Luis Alvarez on 2/3/25.
//

import SwiftUI

public struct StartupContainer<LoadingContent: View, LoadedContent: View>: View {
    
    var startupTasks: () async -> Void
    
    @ViewBuilder var loading: () -> LoadingContent
    @ViewBuilder var content: () -> LoadedContent
    
    @State private var startupComplete = false
    
    public init(startupTasks: @escaping () async -> Void, loading: @escaping () -> LoadingContent, content: @escaping () -> LoadedContent) {
        self.startupTasks = startupTasks
        self.loading = loading
        self.content = content
    }
    
    public var body: some View {
        ZStack {
            if startupComplete {
                MainFrame {
                    content()
                }
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
