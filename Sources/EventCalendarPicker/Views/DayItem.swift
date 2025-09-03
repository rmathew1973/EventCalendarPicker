//
//  DayItem.swift
//  EventCalendarPicker
//
//  Created by Mathews, Russell on 8/29/25.
//

import Foundation
import SwiftUI

struct DayItem: View {
    @EnvironmentObject var dateService: DateService
    let day: Day
    
    var body: some View {
        if day.isInDatesArray {
            if dateService.selectedDate == day.date {
                Button {
                    dateService.selectedDate = day.date
                } label: {
                    ZStack {
                        Circle()
                            .foregroundColor(dateService.selectedColor)
                        Text("\(day.dayOfMonth)")
                            .font(.system(size: 20, weight: .bold))
                            .scaledToFit()
                            .minimumScaleFactor(0.5)
                            .foregroundStyle(dateService.selectedTextColor)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 36)
                }
            } else {
                Button {
                    dateService.selectedDate = day.date
                } label: {
                    Text("\(day.dayOfMonth)")
                        .font(.system(size: 20, weight: .bold))
                        .scaledToFit()
                        .minimumScaleFactor(0.5)
                        .foregroundStyle(dateService.textColor)
                        .frame(maxWidth: .infinity)
                        .frame(height: 36)
                        .background(dateService.selectedColor
                            .frame(height: 3)
                            .offset(y: 14)
                            .padding(.horizontal, 8)
                        )
                }
            }
        } else {
            Text("\(day.dayOfMonth)")
                .font(.system(size: 20, weight: .bold))
                .scaledToFit()
                .minimumScaleFactor(0.5)
                .foregroundStyle(dateService.disabledColor)
                .frame(maxWidth: .infinity)
                .frame(height: 36)
        }
    }
}

