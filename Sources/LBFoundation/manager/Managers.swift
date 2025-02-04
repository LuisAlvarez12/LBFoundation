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
    
    public func addFeatures(features: [LBFeature]) {
        self.features = features.reduce(into: [String: LBFeature]()) { dict, feature in
            dict[type(of: feature).featureKey, default: feature]
        }
    }
    
    public func fetchFeature(featureKey: String) -> any LBFeature {
        return self.features[featureKey]!
    }
}

public protocol LBFeature {
    static var featureKey: String { get }
}
