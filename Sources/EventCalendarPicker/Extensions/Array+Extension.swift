//
//  Array+Extension.swift
//  EventCalendarPicker
//
//  Created by Mathews, Russell on 8/31/25.
//
import Foundation

extension Array {
    func removingDuplicates<T: Hashable>(by key: (Element) -> T) -> [Element] {
        var seen = Set<T>()
        return filter { seen.insert(key($0)).inserted }
    }
}
