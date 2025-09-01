//
//  NextPreviousHeading.swift
//  EventCalendarPicker
//
//  Created by Mathews, Russell on 8/28/25.
//

import SwiftUI

@available(iOS 17.0, *)
struct NextPreviousHeading: View {
    
    @EnvironmentObject var dateService: DateService
    var previousForegroundColor: Color {
        if dateService.previousEnabled {
            return dateService.selectedColor
        }
        return dateService.disabledColor
    }
    var nextForegroundColor: Color {
        if dateService.nextEnabled {
            return dateService.selectedColor
        }
        return dateService.disabledColor
    }
    var nextDisabled: Bool { !dateService.nextEnabled }
    var previousDisabled: Bool { !dateService.previousEnabled }
    
    var body: some View {
        HStack {
            if dateService.isPresenting {
                Button {
                    dateService.isPresenting.toggle()
                } label: {
                    Text("Done")
                        .font(.system(size: 16, weight: .semibold))
                        .scaledToFit()
                        .minimumScaleFactor(0.5)
                        .foregroundStyle(dateService.selectedColor)
                }
            } else {
                Button {
                    dateService.previousMonth()
                } label: {
                    Image(systemName: "chevron.left")
                        .frame(height: 18)
                }
                .foregroundStyle(previousForegroundColor)
                .padding(.trailing, 20)
                .disabled(previousDisabled)
                Button {
                    dateService.nextMonth()
                } label: {
                    Image(systemName: "chevron.right")
                        .frame(height: 18)
                }
                .foregroundStyle(nextForegroundColor)
                .disabled(nextDisabled)
            }
        }
        .frame(height: 36)
    }
}
