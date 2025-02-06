//
//  Router.swift
//  LBFoundation
//
//  Created by Luis Alvarez on 2/5/25.
//

import SwiftUI

public extension Features {
    static var router: Router {
        shared.fetchFeature(featureKey: Router.featureKey) as! Router
    }
}

@Observable
public class Router: LBFeature {
    public static let featureKey: String = "Router"

    public var routes = [any LBRoute]()

    public func navigateTo(route: any LBRoute, clearBackStack: Bool = false) {
        if clearBackStack {
            Features.logger.log("Router", message: "Cleared Backstack")
            Features.logger.log("Router", message: "Set Route: \(route.routeKey)")
            routes = [route]
        } else {
            Features.logger.log("Router", message: "Navigated to: \(route.routeKey)")
            routes.append(route)
        }
    }

    public func popToHome() {
        Features.logger.log("Router", message: "Navigation: Popped to Home")
        routes.removeAll()
    }

    public var currentRoute: (any LBRoute)? {
        routes.last
    }
}

public protocol LBRoute {
    var routeKey: String { get }
}
