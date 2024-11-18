import 'package:carto/enum/price_enum.dart';
import 'package:carto/views/widgets/form/games_form.dart';
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
  late final GeneralForm _generalForm;
  late final ContactForm _contactForm;
  late final OpeningHourForm _openingHourForm;
  late final GamesForm _gamesForm;

  bool _generalFormIsValid = false;
  bool _contactFormIsValid = false;

  // GeneralForm
  late String _name, _address, _latitude, _longitude;
  late PriceEnum _gamePrice;
  late bool _nearTransport, _pmrAccess;

  // ContactForm
  late String _mail, _phoneNumber;

  // OpeningHourForm
  late List<bool> _weekOpening;
  late List<List<TimeOfDay>> _weekOpeningHour;

  // GameForm
  late List<String> _gameTitles;
  late List<int> _gameNumbers;

  @override
  void initState() {
    _generalForm = GeneralForm(
      formIsValid: _handleGeneralFormValidity,
      formChange: _handleGeneralFormChange,
    );
    _name = _generalForm.name;
    _address = _generalForm.address;
    _gamePrice = _generalForm.gamePrice;
    _nearTransport = _generalForm.nearTransport;
    _pmrAccess = _generalForm.pmrAccess;

    _contactForm = ContactForm(
      formIsValid: _handleContactFormValidity,
      formChange: _handleContactFormChange,
    );
    _mail = _contactForm.mail;
    _phoneNumber = _contactForm.phoneNumber;

    _openingHourForm = OpeningHourForm(
      weekOpeningChange: _handleOpeningHourFormOpeningChange,
      weekOpeningHourChange: _handleOpeningHourFormOpeningHourChange,
    );
    _weekOpening = _openingHourForm.weekOpening;
    _weekOpeningHour = _openingHourForm.weekOpeningHour;

    _gamesForm = GamesForm(
      formChange: _handleGameFormChange,
    );
    _gameTitles = _gamesForm.gameTitles;
    _gameNumbers = [];
    for(String _ in _gameTitles) {
      _gameNumbers.add(0);
    }

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
              Padding( padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                child : _generalForm
              ),
              Padding( padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                child : _contactForm
              ),
              Padding( padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                child : _openingHourForm
              ),
              Padding( padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                child : _gamesForm
              ),
              Padding( padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                child : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: formIsValid() ? Colors.white : Colors.grey,
                  disabledForegroundColor: Colors.grey.withOpacity(0.38),
                  disabledBackgroundColor: Colors.grey.withOpacity(0.12),
                 ),
                  child: const Text("Suggérer un établissement"),
                  onPressed: () {
                    formIsValid() ?
                    Navigator.pushNamed(context, '/thank',)
                    : null;
                  },
                )
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
    _latitude = newValues[2];
    _longitude = newValues[3];
    _gamePrice = PriceEnum.fromString(newValues[4]);
    _nearTransport = newValues[5] == "true";
    _pmrAccess = newValues[6] == "true";
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
      List<List<TimeOfDay>> newWeekOpeningHour
  ) {
    _weekOpeningHour = newWeekOpeningHour;
  }

  void _handleGameFormChange(List<int> newGameNumbers) {
    _gameNumbers = newGameNumbers;
  }
}