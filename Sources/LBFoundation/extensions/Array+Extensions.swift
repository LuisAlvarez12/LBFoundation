//
//  Array+Extensions.swift
//  UnderCovers
//
//  Created by Luis Alvarez on 12/23/24.
//
import Foundation

public extension Array {
    /// Safely retrieves an element at the specified index
    ///
    /// - Parameter index: The index of the element to retrieve
    /// - Returns: The element at the specified index if it exists, nil otherwise
    /// - Complexity: O(1)
    public func safeIndex(_ index: Int) -> Element? {
        guard index >= 0, index < count else { return nil }
        return self[index]
    }
}

public extension Sequence where Iterator.Element: Hashable {
    public func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}

public extension Collection {
    var indexedDictionary: [Int: Element] {
        return Dictionary(uniqueKeysWithValues: enumerated().map { ($0, $1) })
    }
}
