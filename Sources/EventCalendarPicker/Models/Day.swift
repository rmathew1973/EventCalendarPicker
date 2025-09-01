//
//  Day.swift
//  EventCalendarPicker
//
//  Created by Mathews, Russell on 8/28/25.
//

import Foundation

struct Day: Identifiable, Equatable, Hashable {
    let id: UUID = UUID()
    let name: String // e.g., "Monday"
    let dayOfMonth: Int // e.g., 1
    let date: Date // The full date object for this day
    let isInDatesArray: Bool // Indicates if this day is in the input dates array
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(dayOfMonth)
    }
    
    static func == (lhs: Day, rhs: Day) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name && lhs.dayOfMonth == rhs.dayOfMonth
    }
}
