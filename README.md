# Zentime

Zentime is a simple app for tracking your working hours and breaks.
It helps you visualize your weekly worktime and maintain a healthy balance between productivity and rest.

Some companies rely on trust-based working hours (e.g., 40h/week). Zentime lets you easily track your time without manual paperwork — so you always know how much you’ve worked or rested.

## Documentation

### Screens

_`main.dart`_

The `main.dart` class mainly renders the Scaffholding of the entire app.

It holds a bottom navigation bar that changes it's index everytime a new tab gets clicked.

According to this index, these three classes get rendered in the body of the scaffold:

- `dashboard_screen.dart`
- `settings_screen.dart`
- `statistics_screen.dart`

_`dashboard_screen.dart`_

The `dashboard_screen.dart` class is responsible for rendering the body of the homepage.

As of now, all the text and diagrams are hardcoded, so nothing shows the data as expected.

The `dashboard_screen.dart` renderes a timeline:

The `timeline_item.dart` class contains of a row with 2 childs:

On the right side, the text gets rendered. On the right to the dots, the time gets shown and between the dots, the label given.

On the left side, a circle and a dashed line are rendered. The circle gets rendered in the class itself and is a 12x12 px circle.

The dashed line is packed in a sized Box with a heigth of 100 px. The dashed line gets rendered by the `dashed_line_painter`, which renderes many lines with a given height and a given gap in between with a loop.

---

### Logic

**A workday is described by the `day_entry.dart` class.**

It contains of the following:

- day:
  - The day of the day entry.
  - Described as a `DateTime`.
- workSessions:
  - A list of all the times, when the user worked.
  - Described as a list of the custom type `WorkSession`.
- breakSessions:

  - A list of all the times, when the user took a break.
  - Described as a list of the custom type `WorkSession`. _Although it describes the amount and length of the breaks, the same datatype is used because it just defines a start and finish of an event_

- sick:

  - A bool that descibes, if the user was sick on this day.
  - Described as a `bool`.

- holiday:
  - A bool that descibes, if the user was on holiday on this day.
  - Described as a `bool`.

Only the `day` attribute is required.

It has four functions:

- `getWorkTime()` -> returns the total time the user worked on this day as a `Duration` data type.
- `getBreakTime()`-> returns the total time the user took a break on this day as a `Duration` data type.
- `toJson()` -> returns a `Map` that is formatted like a json file.
- `fromJson()` -> takes a `Map` and returns a `DayEntry` with the given parameters from the json.

**⚠️ IMPORTANT**: There is no try catch implementation, if the json file is not compatible. The program will crash or throw an error if a wrong json is inputted. Because the json is saved on the users device, the user could theoretically modify the json and cause the app to crash entirely.

**The `work_session.dart` class describes an event:**

It stores an start and finish `DateTime`, which is required in the constructor. It has three functions:

- `getDuration()` -> it returns the duration of the event.
- `toJson()` -> returns a `Map` that is formatted like a json file.
- `fromJson()` -> takes a `Map` and returns a `WorkSession` with the given parameters from the json.

**⚠️ IMPORTANT**: The same bug as before exists here!

**`day_repository.dart`:**

The Day Repository is a class for easy loading and saving of data.

It has three functions:

- `saveDay()` -> Takes an `DayEntry` and stores the day entry as a json in the Hive Box. The key is the day attribute in the `DayEntry` formatted as an ISO8601 String.
- `getDay()` -> Takes a date parameter as an `DateTime`. If there is an entry for that date, it returns an `DayEntry` Object with the corresponding Parameters.
- `getAllDays()` -> Returns a list of all the days, the HiveBox stores. It has no real function in the app so far, but could be useful for exporting all days.

## Testing the App

To test the app on your local pc, clone the repository by executing:

> `git clone {repository.git}`

You have to have flutter version >=3.29.0 installed.

If you're unsure how to install flutter, you can visit the [Flutter Docs](https://docs.flutter.dev/).

If you have everything installed, run:

> `flutter run`

Select a system where you want to run the app on, e.g.:

- macOS (macos)
- Chrome (chrome)
- ...

---

## Contributing

Contributions are welcome!

1. Fork the repository
2. Create a new branch (`git checkout -b feature/your-feature`)
3. Commit your changes
4. Push to your fork and open a Pull Request
