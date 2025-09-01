//
//  EventCalendarControl.swift
//  RDM Solutions Inc.
//
//  Created by Russell Mathews on 6/10/24.
//

import Foundation
import SwiftUI

@available(iOS 17.0, *)
struct EventCalendarControl: View {
    @StateObject var dateService: DateService
    @Binding var selectedDate: Date
    
    init(selectedDate: Binding<Date>, dates: [Date], textColor: Color = .black, selectedColor: Color = .red, selectedTextColor: Color = .white, disabledColor: Color = .gray, dateChanged: @escaping (_: Date) -> Void) {
        self._dateService = StateObject(wrappedValue: DateService(
                    dateChanged: dateChanged,
                    dates: dates.sorted(),
                    selectedDate: selectedDate.wrappedValue,
                    textColor: textColor,
                    selectedColor: selectedColor,
                    selectedTextColor: selectedTextColor,
                    disabledColor: disabledColor
                ))
        _selectedDate = selectedDate
    }
    
    var body: some View {
        VStack {
            HStack {
                CalendarHeading()
                    .environmentObject(dateService)
                Spacer()
                NextPreviousHeading()
                    .environmentObject(dateService)
            }
            .frame(height: 36)
            if dateService.isPresenting {
                HStack(alignment: .center) {
                    PickerView()
                        .environmentObject(dateService)
                }
            } else {
                VStack {
                    DayLabelHeading()
                        .environmentObject(dateService)
                    WeekView()
                        .environmentObject(dateService)
                }
            }
        }
        .onChange(of: dateService.selectedDate) {
            selectedDate = $0
        }
    }
}

@available(iOS 17.0, *)
struct ContentView: View {
    let currentDate: Date
    let calendar: Calendar
    let dates: [Date]
    
    init() {
        currentDate = Date()
        calendar = Calendar.current
        dates = [currentDate, Calendar.current.date(byAdding: .day, value: 2, to: Date())!, Calendar.current.date(byAdding: .day, value: 5, to: Date())!, Calendar.current.date(byAdding: .day, value: 10, to: Date())!, Calendar.current.date(byAdding: .day, value: 15, to: Date())!, Calendar.current.date(byAdding: .year, value: 1, to: Date())!, Calendar.current.date(byAdding: .year, value: 2, to: Date())!, Calendar.current.date(byAdding: .year, value: 3, to: Date())!, Calendar.current.date(byAdding: .year, value: 4, to: Date())!]
    }
    
    var body: some View {
        VStack {
            Spacer()
            EventCalendarControl(selectedDate: .constant(currentDate), dates: dates) { _ in
                
            }
            .padding(32)
            Spacer()
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    ContentView()
}
