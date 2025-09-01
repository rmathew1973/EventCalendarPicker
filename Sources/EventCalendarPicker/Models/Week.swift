//
//  Week.swift
//  EventCalendarPicker
//
//  Created by Mathews, Russell on 8/28/25.
//

import Foundation

struct Week: Identifiable, Equatable, Hashable {
    let id: UUID = UUID()
    let number: Int // Week number within the year
    var days: [Day]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(number)
    }
    
    static func == (lhs: Week, rhs: Week) -> Bool {
        lhs.id == rhs.id && lhs.number == rhs.number
    }
}
