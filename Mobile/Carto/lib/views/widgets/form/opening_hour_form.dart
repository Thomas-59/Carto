import 'package:carto/views/widgets/constants.dart';
import 'package:carto/views/widgets/form/other_fields/hour_piker.dart';
import 'package:flutter/material.dart';

import '../../../utils/opening_hours.dart';

class OpeningHourForm extends StatefulWidget {
  final ValueChanged<WeekOpening> weekOpeningChange;
  final WeekOpening? weekOpeningHour;

  const OpeningHourForm({
    super.key,
    required this.weekOpeningChange,
    this.weekOpeningHour,
  });

  @override
  State<OpeningHourForm> createState() => _OpeningHourFormState();
}

class _OpeningHourFormState extends State<OpeningHourForm> {
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

  void _weekOpeningChange() {
    widget.weekOpeningChange(_weekOpeningHour);
  }

}