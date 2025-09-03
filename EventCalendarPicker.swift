//
//  EventCalendarControl.swift
//  RDM Solutions Inc.
//
//  Created by Russell Mathews on 6/10/24.
//

import Foundation
import SwiftUI

@available(iOS 17.0, *)
struct EventCalendarPicker: View {
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
