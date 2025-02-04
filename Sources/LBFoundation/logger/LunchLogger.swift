//
//  LunchLogger.swift
//  LBFoundation
//
//  Created by Luis Alvarez on 2/3/25.
//


//
//  LunchLogger.swift
//  LunchBox
//
//  Created by Luis Alvarez on 2/2/25.
//

import SwiftUI

public extension Features {
    
    public static var logger: LBLogger {
        shared.fetchFeature(featureKey: LBLogger.featureKey) as! LBLogger
    }
}

/// A logging utility for the LunchBox framework
public class LBLogger : LBFeature {

    public static let featureKey: String = "Logger"
    
    private static let spacing = "   → "
    
    /// Set Logtypes here to ignore specific event types
    var ignoredEvents: [LBLogger.LogType] = []
    
    var lastKey: String = ""

    /// Logs a message with a specific key and type
    /// - Parameters:
    ///   - key: The key or category of the log message
    ///   - message: The message to log
    ///   - type: The type of log message
    public func log(_ key: String, message: String, type: LBLogger.LogType = .Debug) {
        if !ignoredEvents.contains(type) {
            innerPrint(key, message: message, type: type)
        }
    }

    /// Internal print function that formats and outputs the log message
    /// - Parameters:
    ///   - key: The key or category of the log message
    ///   - message: The message to log
    ///   - type: The type of log message (defaults to .Error)
    private func innerPrint(_ key: String, message: String, type: LogType = .Debug) {
        self.innerPrintKey(key)
        print("LunchLogger |  \(Self.spacing) \(type.typeString) | \(message)")
    }
    
    private func innerPrintKey(_ key: String) {
        if key != lastKey {
            lastKey = key
            print("LunchLogger | Key: \(lastKey)")
        }
    }

    /// Represents different types of log messages
    public enum LogType {
        case Debug, Error, NetworkFailure, NetworkSuccess, CacheFailure, CacheSuccess, Success, Monitoring

        /// String representation of the log type
        public var typeString: String {
            switch self {
            case .Debug:
                "DEBUG"
            case .Error:
                "ERROR"
            case .NetworkFailure:
                "NETWORK ERROR"
            case .NetworkSuccess:
                "network success"
            case .CacheFailure:
                "CACHE FAILURE"
            case .CacheSuccess:
                "cache success"
            case .Success:
                "success"
            case .Monitoring:
                "monitoring"
            }
        }
    }
}

/// Convenience function to log debug messages
/// - Parameters:
///   - key: The key or category of the log message (default: empty string)
///   - message: The message to log
///   - type: The type of log message (default: .Debug)
public func logs(_ key: String = "", message: String, type: LBLogger.LogType = .Debug) {
    Features.logger.log(key, message: message, type: type)
}

/// Convenience function to log error messages
/// - Parameters:
///   - key: The key or category of the log message (default: empty string)
///   - message: The message to log
///   - type: The type of log message (default: .Error)
public func errors(_ key: String = "", message: String, type: LBLogger.LogType = .Error) {
    Features.logger.log(key, message: message, type: type)
}

#Preview {
    VStack {
        Button("Log1", action: {
           logs("Luis", message: "Tester")
        })
        Button("Log1", action: {
           logs("Luis2", message: "Tester")
        })
    }
}
