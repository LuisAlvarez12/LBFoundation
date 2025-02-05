//
//  Managers.swift
//  LBFoundation
//
//  Created by Luis Alvarez on 2/3/25.
//

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
        
        shared.features = appFeatures
        
        appFeatures.forEach {
            logger.log("App Features", message: "Feature Added: \($0.key)")
        }
        
    }
    
    public func fetchFeature(featureKey: String) -> any LBFeature {
        return self.features[featureKey]!
    }
}

public protocol LBFeature {
    static var featureKey: String { get }
}
