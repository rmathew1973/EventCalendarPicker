# EventCalendarPicker
SwiftUI Event Calendar Picker

This library creates a customizable calendar for SwiftUI that allows you to pass in an array of dates and a selected date.  The calendar then limits the year, month and day selection according to the dates passed in.  Please feel free to send requests and I'll do my best to keep up with fixes or submit a pull request if you would like to contribute.

To implement it you can add it to a view with the arguments like this

```
import SwiftUI

struct ContentView: View {
  @State var date: Date = Date()
  let dates: [Date] = [Date()]

  var body: some View {
    VStack {
      EventCalendarPicker(
        selectedDate: $date,
        dates: dates,
        textColor: .black,
        selectedColor: .purple,
        selectedTextColor: .white,
        disabledColor: .black ) { newDate in
          print(newDate)
        }
        .padding(16)
    }
  }
}
```


https://github.com/user-attachments/assets/3f2b623c-e444-4698-96d8-cdabc6747238




