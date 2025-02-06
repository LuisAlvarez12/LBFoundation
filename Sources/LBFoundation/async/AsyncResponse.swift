//
//  AsyncResponse.swift
//
//
//  Created by Luis Alvarez on 9/14/23.
//

import SwiftUI

/// Protocol representing the result of an asynchronous operation
public protocol AsyncResponse {
    var feature: String { get set }
}

/// Represents a successful asynchronous operation
public struct AsyncSuccess: AsyncResponse {
    // feature name for Success
    public var feature: String = ""
}

/// Represents a failed asynchronous operation with optional error details
public struct AsyncFailure: AsyncResponse, Error {
    // feature name for failure
    public var feature: String = ""

    public var message: String

    public init(feature: String = "", message: String = "", logError: Bool = true) {
        self.feature = feature
        self.message = message

        if logError {
            let keyName = if message.isEmpty {
                "AsyncFailure"
            } else {
                "AsyncFailure: \(feature)"
            }

            Features.logger.log(keyName, message: message)
        }
    }
}
