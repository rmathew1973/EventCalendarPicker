//
//  Month.swift
//  EventCalendarPicker
//
//  Created by Mathews, Russell on 8/28/25.
//

import Foundation

struct Month: Identifiable, Equatable, Hashable {
    let id: UUID = UUID()
    let name: String
    var weeks: [Week]
    let dates: [Date] // Dates belonging to this month
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
    
    static func == (lhs: Month, rhs: Month) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name
    }
}
