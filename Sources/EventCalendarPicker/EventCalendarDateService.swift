//
//  DateService.swift
//  EventCalendarPicker
//
//  Created by Mathews, Russell on 8/29/25.
//

import Combine
import Foundation
import SwiftUI

class EventCalendarDateService: ObservableObject {
    @Published var firstDateOfMonth: Date
    @Published var month: EventCalendarDateServiceModels.Month {
        didSet {
            self.changeMonth()
        }
    }
    @Published var year: EventCalendarDateServiceModels.Year {
        didSet {
            self.changeYear()
        }
    }
    @Published var isPresenting: Bool
    @Published var years: [EventCalendarDateServiceModels.Year]
    @Published var selectedDate: Date
    var dateChanged: (_ selectedDate: Date) -> Void
    let textColor: Color
    let selectedColor: Color
    let selectedTextColor: Color
    let disabledColor: Color
    let dates: [Date]
    
    var nextEnabled: Bool {
        if years.firstIndex(of: year)! < years.count - 1 || year.months.firstIndex(of: month)! < year.months.count - 1 {
            return true
        }
        return false
    }
    
    var previousEnabled: Bool {
        if Date.firstDateForMonthYear(month: month.name, year: year.name) > dates.min() ?? Date() { return true }
        return false
    }
    
    init(dateChanged: @escaping (_ selectedDate: Date) -> Void, dates: [Date], selectedDate: Date, textColor: Color = .black, selectedColor: Color = .red, selectedTextColor: Color = .white, disabledColor: Color = .gray) {
        self.dateChanged = dateChanged
        self.textColor = textColor
        self.selectedColor = selectedColor
        self.selectedTextColor = selectedTextColor
        self.disabledColor = disabledColor
        self.dates = dates
        self.selectedDate = selectedDate
        self.firstDateOfMonth = selectedDate
        self.isPresenting = false
        let starYear = EventCalendarDateServiceModels.Year(name: Date().yearString, months: [EventCalendarDateServiceModels.Month(name: Date().monthString, weeks: [], dates: dates)])
        self.years = [starYear]
        self.year = starYear
        self.month = starYear.months.first!
        self.years = createYearModels(from: dates)
        self.year = years.first!
        self.month = year.months.first!
    }
    
    func previousMonth() {
        if year.months.firstIndex(of: month)! == 0 && years.firstIndex(of: year)! == 0 {
            return
        }
        if year.months.firstIndex(of: month)! == 0 {
            year = years[years.firstIndex(of: year)! - 1]
            month = year.months.last!
            return
        }
        month = year.months[year.months.firstIndex(of: month)! - 1]
    }
    
    func nextMonth() {
        if year.months.firstIndex(of: month) == year.months.count - 1 && years.firstIndex(of: year) == years.count - 1 {
            return
        }
        if year.months.firstIndex(of: month)! == year.months.count - 1 {
            year = years[years.firstIndex(of: year)! + 1]
            month = year.months.first!
            return
        }
        month = year.months[year.months.firstIndex(of: month)! + 1]
    }
    
    func changeMonth() {
        firstDateOfMonth = month.dates.first!
    }
    
    func changeYear() {
        month = year.months.first!
        firstDateOfMonth = month.dates.first!
    }
    
    func createYearModels(from dates: [Date]) -> [EventCalendarDateServiceModels.Year] {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM" // Full month name
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "EEEE" // Full day name
        
        // Group dates by year
        var yearDict: [Int: [Date]] = [:]
        for date in dates {
            let year = calendar.component(.year, from: date)
            yearDict[year, default: []].append(date)
        }
        
        // Create year models, sorted by year (least to greatest)
        let years: [EventCalendarDateServiceModels.Year] = yearDict.keys.sorted().map { yearNum in
            let yearDates = yearDict[yearNum]!
            
            // Group dates by month
            var monthDict: [Int: [Date]] = [:]
            for date in yearDates {
                let month = calendar.component(.month, from: date)
                monthDict[month, default: []].append(date)
            }
            
            // Create month models, sorted by month (least to greatest)
            let months: [EventCalendarDateServiceModels.Month] = monthDict.keys.sorted().map { monthNum in
                var monthDates = monthDict[monthNum]!
                monthDates.sort { $0 < $1 } // Sort dates chronologically
                
                // Determine the range of days for the month
                let sampleDate = monthDates.first!
                let year = calendar.component(.year, from: sampleDate)
                let startOfMonth = calendar.date(from: DateComponents(year: year, month: monthNum, day: 1))!
                let endOfMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth)!
                
                // Group days by week of year
                var weekDict: [Int: [EventCalendarDateServiceModels.Day]] = [:]
                var currentDate = startOfMonth
                while currentDate < endOfMonth {
                    let dayOfMonth = calendar.component(.day, from: currentDate)
                    let weekNum = calendar.component(.weekOfYear, from: currentDate)
                    let dayName = dayFormatter.string(from: currentDate)
                    let isInDatesArray = monthDates.contains { calendar.isDate($0, equalTo: currentDate, toGranularity: .day) }
                    
                    let day = EventCalendarDateServiceModels.Day(name: dayName, dayOfMonth: dayOfMonth, date: currentDate, isInDatesArray: isInDatesArray)
                    weekDict[weekNum, default: []].append(day)
                    
                    currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
                }
                
                // Create week models for all weeks in the month, sorted by week number
                let weekRange = calendar.range(of: .weekOfYear, in: .month, for: startOfMonth)!
                let weekNumbers = Array(weekRange)
                let weeks: [EventCalendarDateServiceModels.Week] = weekNumbers.sorted().map { weekNum in
                    let days = weekDict[weekNum, default: []].sorted { $0.dayOfMonth < $1.dayOfMonth }
                    return EventCalendarDateServiceModels.Week(number: weekNum, days: days)
                }
                
                // Get month name from a sample date
                let monthName = dateFormatter.string(from: sampleDate)
                
                return EventCalendarDateServiceModels.Month(name: monthName, weeks: weeks, dates: monthDates)
            }
            
            return EventCalendarDateServiceModels.Year(name: "\(yearNum)", months: months)
        }
        
        return years
    }
}

fileprivate extension Date {
    
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
