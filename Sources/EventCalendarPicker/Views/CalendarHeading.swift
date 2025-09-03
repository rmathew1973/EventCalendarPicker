//
//  CalendarHeading.swift
//  EventCalendarPicker
//
//  Created by Mathews, Russell on 8/28/25.
//

import SwiftUI

struct CalendarHeading: View {
    
    @EnvironmentObject var dateService: DateService
    
    var body: some View {
        HStack {
            Text("\(dateService.month.name) \(dateService.year.name)")
                .font(.system(size: 20, weight: .semibold))
                .scaledToFit()
                .minimumScaleFactor(0.5)
                .foregroundStyle(dateService.textColor)
                .padding(.trailing, 8)
            Button {
                withAnimation {
                    dateService.isPresenting.toggle()
                }
            } label: {
                Image(systemName: dateService.isPresenting ? "chevron.up" : "chevron.down")
                    .frame(width: 6)
                    .foregroundStyle(dateService.selectedColor)
            }
        }
        .frame(height: 36)
    }
}

