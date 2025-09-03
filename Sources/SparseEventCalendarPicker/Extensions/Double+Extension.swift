//
//  Double+Extension.swift
//  EventCalendarPicker
//
//  Created by Mathews, Russell on 8/28/25.
//

import Foundation

extension Optional where Wrapped == Double {
    
    var orZero: Double {
        switch self {
        case .some(let value):
            return value
        case .none:
            return 0.0
        }
    }

}
