//
//  PickerView.swift
//  EventCalendarPicker
//
//  Created by Mathews, Russell on 8/28/25.
//

import Foundation
import SwiftUI

struct PickerView: View {
    @EnvironmentObject var dateService: DateService
    
    var body: some View {
        HStack {
            Picker(selection: $dateService.month, label: Text("")) {
                ForEach(dateService.year.months) { month in
                    Text(month.name)
                        .tag(month)
                }
            }
            .pickerStyle(.wheel)
            Picker(selection: $dateService.year, label: Text("")) {
                ForEach(dateService.years) { year in
                    Text(year.name)
                        .tag(year)
                }
            }
            .pickerStyle(.wheel)
        }
    }
}

