//
//  SparseDayLabelHeading.swift
//  EventCalendarPicker
//
//  Created by Mathews, Russell on 8/28/25.
//

import SwiftUI

struct SparseDayLabelHeading: View {
    @EnvironmentObject var dateService: DateService
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 7), spacing: 0) {
            ForEach(Date.dayLabels, id: \.self) { item in
                Text(item)
                    .font(.system(size: 16, weight: .semibold))
                    .minimumScaleFactor(0.5)
                    .foregroundStyle(dateService.textColor)
                    .frame(maxWidth: .infinity)
                    .frame(height: 36)
            }
        }
    }
}
