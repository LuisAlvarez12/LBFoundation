//
//  Global+Extensions.swift
//  LBFoundation
//
//  Created by Luis Alvarez on 2/4/25.
//

import SwiftUI

public func delay(_ seconds: Double) async {
    try? await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
}
