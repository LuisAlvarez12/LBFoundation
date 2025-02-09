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

public struct AppRoute: Hashable, Equatable {
    public var route: any LBRoute

    public static func == (_: AppRoute, _: AppRoute) -> Bool {
        return false
    }

    public func hash(into _: inout Hasher) {
        // Provide a way to hash your route. For example, if LBRoute has an identifier:
        // hasher.combine(route.identifier)
    }
}

@Observable
public class Router: LBFeature {
    public static let featureKey: String = "Router"

    public var routes = [AppRoute]()

    public func navigateTo(route: any LBRoute, clearBackStack: Bool = false) {
        if clearBackStack {
            Features.logger.log("Router", message: "Cleared Backstack")
            Features.logger.log("Router", message: "Set Route: \(route.routeKey)")
            routes = [AppRoute(route: route)]
        } else {
            Features.logger.log("Router", message: "Navigated to: \(route.routeKey)")
            routes.append(AppRoute(route: route))
        }
    }

    public func popToHome() {
        Features.logger.log("Router", message: "Navigation: Popped to Home")
        routes.removeAll()
    }

    public func pop() {
        Features.logger.log("Router", message: "Navigation: Popped backstack")
        routes.removeLast()
    }

    public var currentRoute: (any LBRoute)? {
        routes.last?.route
    }
}

public protocol LBRoute: Hashable {
    var routeKey: String { get }
    var title: String { get } L
}
