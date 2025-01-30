import 'package:flutter/material.dart';

import '../enum/day_of_the_week_enum.dart';

/// The opening hours of a establishment
class OpeningHours {
  /// The day of the week
  final DayOfTheWeekEnum dayOfTheWeek;

  /// The hour when the establishment open is door
  TimeOfDay openingTime;

  /// The hour when the establishment close is door
  TimeOfDay closingTime;

  /// A boolean to show if the establishment is open
  bool isClosed;

  /// The initializer of the class
  OpeningHours(
    this.dayOfTheWeek,
    this.openingTime,
    this.closingTime,
    this.isClosed,
  );
}

/// The OpeningHours of a establishment in a week
class WeekOpening {
  /// The OpeningHours of monday
  OpeningHours monday = OpeningHours(
      DayOfTheWeekEnum.monday,
      const TimeOfDay(hour: 0, minute: 0),
      const TimeOfDay(hour: 23, minute: 59),
      false
  );

  /// The OpeningHours of tuesday
  OpeningHours tuesday = OpeningHours(
      DayOfTheWeekEnum.tuesday,
      const TimeOfDay(hour: 0, minute: 0),
      const TimeOfDay(hour: 23, minute: 59),
      false
  );

  /// The OpeningHours of wednesday
  OpeningHours wednesday = OpeningHours(
      DayOfTheWeekEnum.wednesday,
      const TimeOfDay(hour: 0, minute: 0),
      const TimeOfDay(hour: 23, minute: 59),
      false
  );

  /// The OpeningHours of thursday
  OpeningHours thursday = OpeningHours(
      DayOfTheWeekEnum.thursday,
      const TimeOfDay(hour: 0, minute: 0),
      const TimeOfDay(hour: 23, minute: 59),
      false
  );

  /// The OpeningHours of friday
  OpeningHours friday = OpeningHours(
      DayOfTheWeekEnum.friday,
      const TimeOfDay(hour: 0, minute: 0),
      const TimeOfDay(hour: 23, minute: 59),
      false
  );

  /// The OpeningHours of saturday
  OpeningHours saturday = OpeningHours(
      DayOfTheWeekEnum.saturday,
      const TimeOfDay(hour: 0, minute: 0),
      const TimeOfDay(hour: 23, minute: 59),
      false
  );

  /// The OpeningHours of sunday
  OpeningHours sunday = OpeningHours(
      DayOfTheWeekEnum.sunday,
      const TimeOfDay(hour: 0, minute: 0),
      const TimeOfDay(hour: 23, minute: 59),
      false
  );

  /// The initializer of the class
  WeekOpening({monday, tuesday, wednesday, thursday, friday, saturday, sunday});
}