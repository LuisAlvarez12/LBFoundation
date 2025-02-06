//
//  NotificationsManager.swift
//
//
//  Created by Luis Alvarez on 9/14/23.
//

import SwiftUI

public extension Features {
    @MainActor static var notifications: NotificationsManager {
        shared.fetchFeature(featureKey: NotificationsManager.featureKey) as! NotificationsManager
    }
}

@MainActor
@Observable
public class NotificationsManager: @preconcurrency LBFeature {
    public static let featureKey: String = "Notifications"

    public var notificationMessage: AlertMessage?

    private var currentTask: Task<Void, Never>?

    public func showMessage(_ msg: LocalizedStringKey) {
        Features.haptics.onGeneral()
        updateAlert(alertMessage: AlertMessage(message: msg, color: .blue))
    }

    public func showLoading() {
        Features.haptics.onGeneral()

        withAnimation(.easeIn(duration: 0.1)) {
            notificationMessage = AlertMessage(message: "Setting up your Files", color: .blue, isLoading: true)
        }
    }

    public func error(_ msg: LocalizedStringKey) {
        Features.haptics.onError()
        updateAlert(alertMessage: AlertMessage(message: msg, color: Color.red))
    }

    public func updateAlert(alertMessage: AlertMessage) {
        withAnimation(.easeIn(duration: 0.1)) {
            notificationMessage = alertMessage
        }
        currentTask?.cancel()

        currentTask = hideAlertTask()
    }

    private func hideAlertTask() -> Task<Void, Never> {
        return Task {
            await delay(1.0)

            if Task.isCancelled {
                return
            }

            await MainActor.run {
                withAnimation(.easeIn(duration: 0.2)) {
                    self.notificationMessage = nil
                }
            }
        }
    }
}

private struct FloatingNoticeTestView: View {
    var body: some View {
        VStack {
            Button("Show Alert", action: {
                Features.notifications.showMessage("Hello!")
            })
        }.fullFrame()
    }
}

#Preview {
    StartupContainer(startupTasks: {
        await Features.addFeatures(features: [])
    }, loading: {
        Color.red
    }, content: {
        FloatingNoticeTestView()
    })
}

public struct SimpleNotificationView: View {
    @Environment(\.colorScheme) var colorScheme

    public let title: LocalizedStringKey
    public let image: String
    public var color: Color = .blue
    public var loading: Bool = false

    public init(title: LocalizedStringKey, image: String, color: Color = .blue, loading: Bool = false) {
        self.title = title
        self.image = image
        self.color = color
        self.loading = loading
    }

    public var body: some View {
        HStack(alignment: .center) {
            if loading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.white)
                    .padding(6)
                    .background(Circle().fill(color.gradient))
                    .padding(.vertical)
            } else {
                Image(systemName: image)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .padding(6)
                    .background(Circle().fill(color.gradient))
                    .padding(.vertical)
            }

            Text(title)
                .foregroundColor(currentAppTheme.text.primary)
                .padding(.vertical)

        }.padding(.horizontal).background {
            Capsule().fill(Material.thin)
                .shadow(radius: 2)
        }
    }
}

public struct AlertMessage {
    public let message: LocalizedStringKey
    public var color: Color = .blue
    public var imageName: String = "info.circle.fill"
    public var isLoading: Bool = false

    public init(message: LocalizedStringKey, color: Color = .blue, imageName: String = "info.circle.fill", isLoading: Bool = false) {
        self.message = message
        self.color = color
        self.imageName = imageName
        self.isLoading = isLoading
    }
}

public struct FloatingNotice: View {
    public let alertMessage: AlertMessage

    public init(alertMessage: AlertMessage) {
        self.alertMessage = alertMessage
    }

    public var body: some View {
        SimpleNotificationView(title: alertMessage.message, image: alertMessage.imageName, color: alertMessage.color)
    }
}
