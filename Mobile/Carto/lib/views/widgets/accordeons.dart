import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/establishment.dart';
import 'constants.dart';

/// The widget who show opening hours in a accordion
class HoursAccordion extends StatefulWidget {
  /// The list of opening hour of the week
  final List<DayOfTheWeekElemDto> schedule;

  /// The initializer of the class
  const HoursAccordion({super.key, required this.schedule});

  @override
  _HoursAccordionState createState() => _HoursAccordionState();
}

/// The state of HoursAccordion
class _HoursAccordionState extends State<HoursAccordion> {
  /// If the HoursAccordion is expended
  bool _isExpanded = false;

  /// Return true if the given day is today
  bool isToday(String weekdayFromSchedule) {
    DateTime now = DateTime.now();
    int weekday = now.weekday;
    if (getDayOfWeek(weekday).toUpperCase() == weekdayFromSchedule.toUpperCase()) {
      return true;
    }
    return false;
  }

  /// Give the name of the day by it index
  String getDayOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            title: const Text(
              "Horaires",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: black,
              ),
            ),
            trailing: Icon(
              _isExpanded ? Icons.expand_less : Icons.expand_more,
              color: Colors.grey[800],
            ),
            onExpansionChanged: (bool expanded) {
              setState(() {
                _isExpanded = expanded;
              });
            },
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: widget.schedule.map((daySchedule) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: isToday(daySchedule.dayOfTheWeek.name)? TodayRow(daySchedule: daySchedule) : DayRow(daySchedule: daySchedule),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A row in the HoursAccordion
class DayRow extends StatelessWidget {

  /// The schedule to show
  final DayOfTheWeekElemDto daySchedule;

  /// The initializer of the class
  const DayRow({super.key, required this.daySchedule});

  /// Parse the time to the 'HH:mm' format
  String formatTime(String time) {
    try {
      final parsedTime = DateFormat('HH:mm:ss').parse(time);
      return DateFormat('HH:mm').format(parsedTime);
    } catch (e) {
      return time;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          daySchedule.dayOfTheWeek.value.toLowerCase(),
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
        Text(
          daySchedule.isClosed
              ? "Fermé".toUpperCase()
              : "${formatTime(daySchedule.openingTime)} - ${formatTime(daySchedule.closingTime)}",
          style: TextStyle(
            fontSize: 16,
            color: daySchedule.isClosed ? red : black,
          ),
        ),
      ],
    );
  }
}

/// A row in the HoursAccordion which is today
class TodayRow extends StatelessWidget {

  /// The schedule to show
  final DayOfTheWeekElemDto daySchedule;

  /// The initializer of the class
  const TodayRow({super.key, required this.daySchedule});

  /// Parse the time to the 'HH:mm' format
  String formatTime(String time) {
    try {
      final parsedTime = DateFormat('HH:mm:ss').parse(time);
      return DateFormat('HH:mm').format(parsedTime);
    } catch (e) {
      return time;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          daySchedule.dayOfTheWeek.value.toUpperCase(),
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          daySchedule.isClosed
              ? "Fermé".toUpperCase()
              : "${formatTime(daySchedule.openingTime)} - ${formatTime(daySchedule.closingTime)}",
          style: TextStyle(
            fontSize: 16,
            color: daySchedule.isClosed ? red : black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}