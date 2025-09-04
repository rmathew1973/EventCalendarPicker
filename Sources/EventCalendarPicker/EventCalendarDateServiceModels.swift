//
//  DateServiceModels.swift
//  EventCalendarPicker
//
//  Created by Mathews, Russell on 8/28/25.
//

import Foundation

struct EventCalendarDateServiceModels {
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
}

