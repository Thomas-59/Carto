import 'package:carto/enum/price_enum.dart';
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
  late final Widget _openingHourForm;

  bool _generalFormIsValid = false;
  bool _contactFormIsValid = false;

  // GeneralForm
  String _name = "";
  String _address = "";
  PriceEnum _gamePrice = PriceEnum.medium;
  bool _nearTransport = false;
  bool _pmrAccess = false;

  // ContactForm
  String _mail = "";
  String _phoneNumber = "";

  // OpeningHourForm
  List<bool> _weekOpening = <bool> [
    true,
    true,
    true,
    true,
    true,
    true,
    true
  ];

  List<List<TimeOfDay>> _weekOpeningHour = const <List<TimeOfDay>> [
    <TimeOfDay> [TimeOfDay(hour: 0, minute: 0), TimeOfDay(hour: 0, minute: 0)],
    <TimeOfDay> [TimeOfDay(hour: 0, minute: 0), TimeOfDay(hour: 0, minute: 0)],
    <TimeOfDay> [TimeOfDay(hour: 0, minute: 0), TimeOfDay(hour: 0, minute: 0)],
    <TimeOfDay> [TimeOfDay(hour: 0, minute: 0), TimeOfDay(hour: 0, minute: 0)],
    <TimeOfDay> [TimeOfDay(hour: 0, minute: 0), TimeOfDay(hour: 0, minute: 0)],
    <TimeOfDay> [TimeOfDay(hour: 0, minute: 0), TimeOfDay(hour: 0, minute: 0)],
    <TimeOfDay> [TimeOfDay(hour: 0, minute: 0), TimeOfDay(hour: 0, minute: 0)]
  ];

  @override
  void initState() {
    _generalForm = GeneralForm(
      formIsValid: _handleGeneralFormValidity,
      formChange: _handleGeneralFormChange,
      name: _name,
      address: _address,
      gamePrice: _gamePrice,
      nearTransport: _nearTransport,
      pmrAccess: _pmrAccess,
    );
    _contactForm = ContactForm(
      formIsValid: _handleContactFormValidity,
      formChange: _handleContactFormChange,
      mail: _mail,
      phoneNumber: _phoneNumber,
    );
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
    return _generalFormIsValid & _contactFormIsValid;
  }

  void _handleGeneralFormValidity(bool formIsValid) {
    setState(() {
      _generalFormIsValid = formIsValid;
    });
  }

  void _handleGeneralFormChange(List<String> newValues) {
    _name = newValues[0];
    _address = newValues[1];
    _gamePrice = PriceEnum.fromString(newValues[2]);
    _nearTransport = newValues[3] == "true";
    _pmrAccess = newValues[4] == "true";
  }

  void _handleContactFormValidity(bool formIsValid) {
    setState(() {
      _contactFormIsValid = formIsValid;
    });
  }

  void _handleContactFormChange(List<String> newValues) {
      _mail = newValues[0];
      _phoneNumber = newValues[1];
  }

  void _handleOpeningHourFormOpeningChange(List<bool> newWeekOpening) {
    _weekOpening = newWeekOpening;
  }

  void _handleOpeningHourFormOpeningHourChange(
      List<List<TimeOfDay>> newWeekOpeningHour) {
    _weekOpeningHour = newWeekOpeningHour;
  }
}