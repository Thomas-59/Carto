import 'package:carto/views/widgets/form/other_fields/hour_piker.dart';
import 'package:flutter/material.dart';

class OpeningHourForm extends StatefulWidget {
  final ValueChanged<List<List<TimeOfDay>>> weekOpeningHourChange;
  final ValueChanged<List<bool>> weekOpeningChange;
  final List<List<TimeOfDay>> weekOpeningHour;
  final List<bool> weekOpening;

  const OpeningHourForm({super.key, required this.weekOpening, required this.weekOpeningChange, required this.weekOpeningHour, required this.weekOpeningHourChange});

  @override
  State<OpeningHourForm> createState() => _OpeningHourFormState();
}

class _OpeningHourFormState extends State<OpeningHourForm> {
  late List<TimeOfDay> _mondayTime;
  late List<TimeOfDay> _tuesdayTime;
  late List<TimeOfDay> _wednesdayTime;
  late List<TimeOfDay> _thursdayTime;
  late List<TimeOfDay> _fridayTime;
  late List<TimeOfDay> _saturdayTime;
  late List<TimeOfDay> _sundayTime;

  late bool _mondayOpening;
  late bool _tuesdayOpening;
  late bool _wednesdayOpening;
  late bool _thursdayOpening;
  late bool _fridayOpening;
  late bool _saturdayOpening;
  late bool _sundayOpening;

  @override
  void initState() {
    super.initState();

    _mondayTime = widget.weekOpeningHour[0];
    _tuesdayTime = widget.weekOpeningHour[1];
    _wednesdayTime = widget.weekOpeningHour[2];
    _thursdayTime = widget.weekOpeningHour[3];
    _fridayTime = widget.weekOpeningHour[4];
    _saturdayTime = widget.weekOpeningHour[5];
    _sundayTime = widget.weekOpeningHour[6];

    _mondayOpening = widget.weekOpening[0];
    _tuesdayOpening = widget.weekOpening[1];
    _wednesdayOpening = widget.weekOpening[2];
    _thursdayOpening = widget.weekOpening[3];
    _fridayOpening = widget.weekOpening[4];
    _saturdayOpening = widget.weekOpening[5];
    _sundayOpening = widget.weekOpening[6];
  }

  bool formIsValid() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Horraire d'ouverture",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const Divider(
            color: Colors.black
        ),
        HourPiker(
            text: "Lundi",
            opened: _mondayOpening,
            onOpeningChange: (bool newOpening) {
              _mondayOpening = newOpening;
              onOpeningChange();
            },
            openingTime: _mondayTime[0],
            closingTime: _mondayTime[1],
            onTimeChange: (List<TimeOfDay> newOpeningTime) {
              _mondayTime = newOpeningTime;
              onTimeChange();
            }
        ),
        HourPiker(
            text: "Mardi",
            opened: _tuesdayOpening,
            onOpeningChange: (bool newOpening) {
              _tuesdayOpening = newOpening;
              onOpeningChange();
            },
            openingTime: _tuesdayTime[0],
            closingTime: _tuesdayTime[1],
            onTimeChange: (List<TimeOfDay> newOpeningTime) {
              _tuesdayTime = newOpeningTime;
              onTimeChange();
            }
        ),
        HourPiker(
            text: "Mercredi",
            opened: _wednesdayOpening,
            onOpeningChange: (bool newOpening) {
              _wednesdayOpening = newOpening;
              onOpeningChange();
            },
            openingTime: _wednesdayTime[0],
            closingTime: _wednesdayTime[1],
            onTimeChange: (List<TimeOfDay> newOpeningTime) {
              _wednesdayTime = newOpeningTime;
              onTimeChange();
            }
        ),
        HourPiker(
            text: "Jeudi",
            opened: _thursdayOpening,
            onOpeningChange: (bool newOpening) {
              _fridayOpening = newOpening;
              onOpeningChange();
            },
            openingTime: _thursdayTime[0],
            closingTime: _thursdayTime[1],
            onTimeChange: (List<TimeOfDay> newOpeningTime) {
              _thursdayTime = newOpeningTime;
              onTimeChange();
            }
        ),
        HourPiker(
            text: "Vendredi",
            opened: _fridayOpening,
            onOpeningChange: (bool newOpening) {
              _fridayOpening = newOpening;
              onOpeningChange();
            },
            openingTime: _fridayTime[0],
            closingTime: _fridayTime[1],
            onTimeChange: (List<TimeOfDay> newOpeningTime) {
              _fridayTime = newOpeningTime;
              onTimeChange();
            }
        ),
        HourPiker(
            text: "Samedi",
            opened: _saturdayOpening,
            onOpeningChange: (bool newOpening) {
              _saturdayOpening = newOpening;
              onOpeningChange();
            },
            openingTime: _saturdayTime[0],
            closingTime: _saturdayTime[1],
            onTimeChange: (List<TimeOfDay> newOpeningTime) {
              _saturdayTime = newOpeningTime;
              onTimeChange();
            }
        ),
        HourPiker(
          text: "Dimanche",
          opened: _sundayOpening,
          onOpeningChange: (bool newOpening) {
            _sundayOpening = newOpening;
            onOpeningChange();
          },
          openingTime: _sundayTime[0],
          closingTime: _sundayTime[1],
          onTimeChange: (List<TimeOfDay> newOpeningTime) {
            _sundayTime = newOpeningTime;
            onTimeChange();
          }
        ),
      ],
    );
  }

  void onOpeningChange() {
    widget.weekOpeningChange(
        <bool> [
          _mondayOpening,
          _tuesdayOpening,
          _wednesdayOpening,
          _thursdayOpening,
          _fridayOpening,
          _saturdayOpening,
          _sundayOpening
        ]
    );
  }

  void onTimeChange() {
    widget.weekOpeningHourChange(
      <List<TimeOfDay>> [
        _mondayTime,
        _tuesdayTime,
        _wednesdayTime,
        _thursdayTime,
        _fridayTime,
        _saturdayTime,
        _sundayTime
      ]
    );
  }

}//const TimeOfDay(hour: 8, minute: 00)