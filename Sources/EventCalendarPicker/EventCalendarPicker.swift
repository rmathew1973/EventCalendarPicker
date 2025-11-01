//
//  EventCalendarPicker.swift
//  RDM Solutions Inc.
//
//  Created by Russell Mathews on 6/10/24.
//

import Foundation
import SwiftUI

public struct EventCalendarPicker: View {
    @StateObject var dateService: DateService
    @Binding var selectedDate: Date
    
    public init(selectedDate: Binding<Date>, dates: [Date], textColor: Color = .black, selectedColor: Color = .red, selectedTextColor: Color = .white, disabledColor: Color = .gray, dateChanged: @escaping (_: Date) -> Void) {
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
    
    public var body: some View {
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
        .onChange(of: dateService.selectedDate) { oldValue, newValue in
            selectedDate = newValue
        }
    }
}

#Preview {
    @Previewable @State var showCalendar: Bool = true
    @Previewable @State var date: Date = Date()
    VStack {
        VStack {
            Spacer()
            VStack {
                if showCalendar {
                    HStack {
                        Spacer()
                        Button {
                            showCalendar.toggle()
                        } label: {
                            Text("Done")
                                .foregroundColor(.purple)
                        }
                    }
                    EventCalendarPicker(selectedDate: $date, dates: [Date(), Calendar.current.date(byAdding: .month, value: 1, to: Date())!, Calendar.current.date(byAdding: .year, value: 2, to: Date())!], textColor: .black, selectedColor: .purple, selectedTextColor: .white, disabledColor: .gray) { date in
                        print(date)
                    }
                } else {
                    HStack {
                        Spacer()
                        Button {
                            showCalendar.toggle()
                        } label: {
                            Text("\($date.wrappedValue.monthString),  \($date.wrappedValue.dayString)  \($date.wrappedValue.yearString)")
                        }
                        Spacer()
                    }
                }
            }
            .padding()
            .background(.white)
            .cornerRadius(12)
            Spacer()
        }
        .padding()
    }
    .background(.gray)
    .ignoresSafeArea()
}
