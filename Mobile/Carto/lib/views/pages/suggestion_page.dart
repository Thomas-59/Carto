import 'package:flutter/material.dart';

import '../widgets/form/contact_form.dart';
import '../widgets/form/general_form.dart';
import '../widgets/form/opening_hour_form.dart';

class SuggestionPage extends StatefulWidget {
  const SuggestionPage({super.key});

  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  late Widget _generalForm;
  late Widget _contactForm;
  late Widget _openingHourForm;

  bool generalFormIsValid = false;
  bool contactFormIsValid = false;

  List<bool> _weekOpening = <bool> [
    true,
    true,
    true,
    true,
    true,
    true,
    true
  ];

  List<List<TimeOfDay>> _weekOpeningHour = <List<TimeOfDay>> [
    <TimeOfDay> [const TimeOfDay(hour: 0, minute: 0), const TimeOfDay(hour: 0, minute: 0)],
    <TimeOfDay> [const TimeOfDay(hour: 0, minute: 0), const TimeOfDay(hour: 0, minute: 0)],
    <TimeOfDay> [const TimeOfDay(hour: 0, minute: 0), const TimeOfDay(hour: 0, minute: 0)],
    <TimeOfDay> [const TimeOfDay(hour: 0, minute: 0), const TimeOfDay(hour: 0, minute: 0)],
    <TimeOfDay> [const TimeOfDay(hour: 0, minute: 0), const TimeOfDay(hour: 0, minute: 0)],
    <TimeOfDay> [const TimeOfDay(hour: 0, minute: 0), const TimeOfDay(hour: 0, minute: 0)],
    <TimeOfDay> [const TimeOfDay(hour: 0, minute: 0), const TimeOfDay(hour: 0, minute: 0)]
  ];

  @override
  void initState() {
    _generalForm = GeneralForm(formIsValid: _handleGeneralFormChange);
    _contactForm = ContactForm(formIsValid: _handleContactFormChange);
    _openingHourForm = OpeningHourForm(
      weekOpening: _weekOpening,
      weekOpeningChange: _handleOpeningHourFormOpeningChange,
      weekOpeningHour: _weekOpeningHour,
      weekOpeningHourChange: _handleOpeningHourFormOpeningHourChange,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            children: [
              _generalForm,
              _contactForm,
              _openingHourForm,
              ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: formIsValid() ? Colors.white : Colors.grey,
                disabledForegroundColor: Colors.grey.withOpacity(0.38),
                disabledBackgroundColor: Colors.grey.withOpacity(0.12),
               ),
                child: const Text("Suggérer un établissement"),
                onPressed: () {
                  formIsValid() ?
                  Navigator.pushNamed(context, '/',)
                  : null;
                },
              ),
            ],
          ),
        ]
      )
    );
  }

  bool formIsValid() {
    return generalFormIsValid & contactFormIsValid;
  }

  void _handleGeneralFormChange(bool formIsValid) {
    setState(() {
      generalFormIsValid = formIsValid;
    });
  }

  void _handleContactFormChange(bool formIsValid) {
    setState(() {
      contactFormIsValid = formIsValid;
    });
  }

  void _handleOpeningHourFormOpeningChange(List<bool> newWeekOpening) {
    _weekOpening = newWeekOpening;
  }

  void _handleOpeningHourFormOpeningHourChange(List<List<TimeOfDay>> newWeekOpeningHour) {
    _weekOpeningHour = newWeekOpeningHour;
  }
}