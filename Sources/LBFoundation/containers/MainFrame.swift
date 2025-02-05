//
//  MainFrame.swift
//  LBFoundation
//
//  Created by Luis Alvarez on 2/4/25.
//

import SwiftUI

public struct MainFrame<Content: View> : View {
    @State var notificationsHelper: NotificationsManager = Features.notifications
    
    @ViewBuilder var content: () -> Content
    
    public init(content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        ZStack {
            content()
                .fullFrame()
        }
        .fullFrame()
        .overlay(alignment: .top, content: {
            if let notificationMessage = notificationsHelper.notificationMessage {
                SimpleNotificationView(title: notificationMessage.message, image: "")
            }
        })
        .hapticsReciever()
    }
}
