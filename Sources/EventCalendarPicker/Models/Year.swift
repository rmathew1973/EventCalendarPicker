//
//  Year.swift
//  EventCalendarPicker
//
//  Created by Mathews, Russell on 8/28/25.
//

import Foundation

struct Year: Identifiable, Equatable, Hashable {
    let id: UUID = UUID()
    let name: String
    var months: [Month]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
    
    static func == (lhs: Year, rhs: Year) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name
    }
}
