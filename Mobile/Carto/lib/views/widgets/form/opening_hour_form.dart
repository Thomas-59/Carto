import 'package:carto/views/widgets/constants.dart';
import 'package:carto/views/widgets/form/other_fields/hour_piker.dart';
import 'package:flutter/material.dart';

import '../../../utils/opening_hours.dart';

/// The frame concerning the opening hour of the establishment in the form
class OpeningHourForm extends StatefulWidget {
  /// The action to take when value change
  final ValueChanged<WeekOpening> weekOpeningChange;
  /// The opening hours of the week to initialize the form
  final WeekOpening? weekOpeningHour;

  /// The initializer of the class
  const OpeningHourForm({
    super.key,
    required this.weekOpeningChange,
    this.weekOpeningHour,
  });

  @override
  State<OpeningHourForm> createState() => _OpeningHourFormState();
}

/// The state of OpeningHourForm
class _OpeningHourFormState extends State<OpeningHourForm> {
  /// The current opening hours of the week in the form
  late WeekOpening _weekOpeningHour;

  @override
  void initState() {
    _weekOpeningHour = widget.weekOpeningHour ?? WeekOpening();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "HORAIRES D'OUVERTURE",
          style: blackTextBold20,
        ),
        const Divider(
            color: Colors.black
        ),
        _setHourPiker(_weekOpeningHour.monday),
        _setHourPiker(_weekOpeningHour.tuesday),
        _setHourPiker(_weekOpeningHour.wednesday),
        _setHourPiker(_weekOpeningHour.thursday),
        _setHourPiker(_weekOpeningHour.friday),
        _setHourPiker(_weekOpeningHour.saturday),
        _setHourPiker(_weekOpeningHour.sunday),
      ],
    );
  }

  /// Set the widget to show and select new hour
  Widget _setHourPiker(OpeningHours openingHours) {
    return HourPiker(
      text: openingHours.dayOfTheWeek.value,
      isClosed: openingHours.isClosed,
      onOpeningChange: (bool newOpening) {
        openingHours.isClosed = newOpening;
        _weekOpeningChange();
      },
      openingTime: openingHours.openingTime,
      closingTime: openingHours.closingTime,
      onTimeChange: (List<TimeOfDay> newOpeningTime) {
        openingHours.openingTime = newOpeningTime[0];
        openingHours.closingTime = newOpeningTime[1];
        _weekOpeningChange();
      }
    );
  }

  /// The action to take on value change
  void _weekOpeningChange() {
    widget.weekOpeningChange(_weekOpeningHour);
  }

}