//
//  WeekView.swift
//  EventCalendarPicker
//
//  Created by Mathews, Russell on 8/28/25.
//

import SwiftUI

struct WeekView: View {
    @EnvironmentObject var dateService: DateService
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 7), spacing: 0) {
            ForEach(dateService.month.weeks) { week in
                ForEach(Date.longDayLabels, id: \.self) { dayName in
                    if let day = week.days.first(where: { $0.name == dayName }) {
                        DayItem(day: day)
                    } else {
                        Color.clear
                            .frame(maxWidth: .infinity)
                            .frame(height: 36)
                    }
                }
            }
        }
    }
}


