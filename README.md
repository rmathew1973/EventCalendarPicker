# EventCalendarPicker
SwiftUI Event Calendar Picker

This library creates a customizable calendar for SwiftUI that allows you to pass in an array of dates and a selected date.  The calendar then limits the year, month and day selection according to the dates passed in.  Please feel free to send requests and I'll do my best to keep up with fixes or submit a pull request if you would like to contribute.

To implement it you can add it to a view with the arguments like this

```
import SwiftUI

struct ContentView: View {
  @State date: Date = Date()
  let dates: [Date] = [Date()]

  var body: some View {
    VStack {
      EventCalendarPicker(
        selectedDate: $prenatalService.selectedDate,
        dates: prenatalService.selectedEventDates,
        textColor: .black,
        selectedColor: .appPurple,
        selectedTextColor: .appPureWhite,
        disabledColor: .appBlack ) { newDate in
          if let selectedEvent = prenatalService.selectedEvents.first(where: { item in
            item.date.shortDate == newDate.shortDate
          }) {
            prenatalService.selectedEvent = selectedEvent
          }
        }
        .padding(BrandConstants.defaultPadding.cgFloat)
    }
  }
}
```


https://github.com/user-attachments/assets/fb983351-d546-4122-a24a-8f6e17ca443f

