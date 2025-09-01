//
//  Date+Extension.swift
//  EventCalendarPicker
//
//  Created by Mathews, Russell on 8/28/25.
//

import Foundation

extension Date {
    
    static let dayLabels = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    static let longDayLabels: [String] = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    var dayString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: self)
    }

    var yearString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self)
    }
    
    var monthString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: self)
    }
    
    var shortDayString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: self)
    }
    
    static func firstDateForMonthYear(month: String, year: String) -> Date {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "d LLLL yyyy"
        return dateFormater.date(from: "1 \(month) \(year)") ?? Date()
    }
    
    static func lastDateOfMonth(month: String, year: String) -> Date {
        let firstDayOfMonth = Date.firstDateForMonthYear(month: month, year: year)
        guard let range = Calendar.current.range(of: .day, in: .month, for: firstDayOfMonth) else {
            return Date()
        }
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "d LLLL yyyy"
        return dateFormater.date(from: "\(range.upperBound) \(month) \(year)") ?? Date()
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: Calendar.current.startOfDay(for: self))) ?? Date()
    }
    
}
