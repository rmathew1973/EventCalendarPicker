//
//  SparseEventCalendar.swift
//  RDM Solutions Inc.
//
//  Created by Russell Mathews on 6/10/24.
//

import Foundation
import SwiftUI

public struct SparseEventCalendar: View {
    @StateObject var dateService: EventCalendarDateService
    @Binding var selectedDate: Date
    
    init(selectedDate: Binding<Date>, dates: [Date], textColor: Color = .black, selectedColor: Color = .red, selectedTextColor: Color = .white, disabledColor: Color = .gray, dateChanged: @escaping (_: Date) -> Void) {
        self._dateService = StateObject(wrappedValue: EventCalendarDateService(
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
    
    public var body: some View {
        VStack {
            HStack {
                EventCalendarHeading()
                    .environmentObject(dateService)
                Spacer()
                EventCalendarNextPreviousHeading()
                    .environmentObject(dateService)
            }
            .frame(height: 36)
            if dateService.isPresenting {
                HStack(alignment: .center) {
                    EventCalendarPickerView()
                        .environmentObject(dateService)
                }
            } else {
                VStack {
                    EventCalendarDayLabelHeading()
                        .environmentObject(dateService)
                    EventCalendarWeekView()
                        .environmentObject(dateService)
                }
            }
        }
        .onChange(of: dateService.selectedDate) { oldValue, newValue in
            selectedDate = newValue
        }
    }
}
