//
//  Managers.swift
//  LBFoundation
//
//  Created by Luis Alvarez on 2/3/25.
//

import SwiftUI

/**
 This is the struct that is allows for shortcut access to all of the managers accessible to
 */
public class Features: @unchecked Sendable {
    public static let shared = Features()

    public var features = [String: LBFeature]()

    @MainActor
    public static func addFeatures(features: [LBFeature]) {
        var appFeatures = Dictionary(uniqueKeysWithValues: features.map { (type(of: $0).featureKey, $0) })

        let logger = LBLogger()
        appFeatures[NotificationsManager.featureKey] = NotificationsManager()
        appFeatures[HapticsManager.featureKey] = HapticsManager()
        appFeatures[AppOpensManager.featureKey] = AppOpensManager()
        appFeatures[LBLogger.featureKey] = logger
        appFeatures[AppThemeManager.featureKey] = AppThemeManager()
        appFeatures[Router.featureKey] = Router()

        shared.features = appFeatures

        for appFeature in appFeatures {
            logger.log("App Features", message: "Feature Added: \(appFeature.key)")
        }
    }

    public func fetchFeature(featureKey: String) -> any LBFeature {
        return features[featureKey]!
    }
}

public extension PreviewUtils {
    struct FeaturesContainer<Content: View>: View {
        let features: [LBFeature]
        @ViewBuilder var content: () -> Content

        public init(features: [LBFeature] = [], content: @escaping () -> Content) {
            self.features = features
            self.content = content
        }

        public var body: some View {
            StartupContainer(startupTasks: {
                Features.addFeatures(features: features)
            }, loading: {
                EmptyView()
            }, content: {
                content()
            })
        }
    }
}

public protocol LBFeature {
    static var featureKey: String { get }
}
