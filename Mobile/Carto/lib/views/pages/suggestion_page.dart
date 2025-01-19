import 'dart:typed_data';

import 'package:carto/enum/price_enum.dart';
import 'package:carto/utils/establishment_games.dart';
import 'package:carto/utils/opening_hours.dart';
import 'package:carto/viewmodel/establishment_view_model.dart';
import 'package:carto/views/widgets/form/games_form.dart';
import 'package:carto/views/widgets/form/contact_form.dart';
import 'package:carto/views/widgets/form/general_form.dart';
import 'package:carto/views/widgets/form/opening_hour_form.dart';
import 'package:carto/views/widgets/constants.dart';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// It the page where the user can suggest a new establishment to add in the
/// application
class SuggestionPage extends StatefulWidget {

  /// The initializer of the class
  const SuggestionPage({super.key});

  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

/// The state of the SuggestionPage stateful widget
class _SuggestionPageState extends State<SuggestionPage> {
  /// The form with the general data field
  late final GeneralForm _generalForm;
  /// The form with the contact field
  late final ContactForm _contactForm;
  /// The form with the opening hour field
  late final OpeningHourForm _openingHourForm;
  /// The form with the games field
  late final GamesForm _gamesForm;

  /// The state of validity of the general field
  bool _generalFormIsValid = false;
  /// The state of validity of the general field
  bool _contactFormIsValid = true;

  // GeneralForm
  /// The name of the establishment
  late String _name,
  /// The address of the establishment
    _address,
  /// The latitude of the establishment
    _latitude,
  /// The longitude of the establishment
    _longitude,
  /// The web site of the establishment
    _site,
  /// The description of the establishment
    _description;
  /// The average price of the game in the establishment
  late PriceEnum _gamePrice;
  /// If the establishment is near the public transport
  late bool _nearTransport,
  /// If the establishment have pmr access
    _pmrAccess;

  // ContactForm
  /// The email address of the establishment
  late String _mail,
  /// The phone number of the establishment
    _phoneNumber;

  // OpeningHourForm
  /// The list of opening hour in the week
  late WeekOpening _weekOpeningHour;

  // GameForm
  /// The list of games in the establishment
  EstablishmentGames _games = EstablishmentGames();

  // Service
  /// The view model to access to the service which communicate with the
  /// establishment part of our API
  EstablishmentViewModel establishmentViewModel = EstablishmentViewModel();

  //image
  /// The image of the establishment
  late Uint8List? _imageBytes;

  @override
  void initState() {
    _generalForm = GeneralForm(
      formIsValid: _handleGeneralFormValidity,
      formChange: _handleGeneralFormChange,
    );
    _name = _generalForm.name;
    _address = _generalForm.address;
    _site = _generalForm.site;
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
      weekOpeningChange: _handleOpeningHourFormChange,
    );
    _weekOpeningHour = WeekOpening();

    _gamesForm = GamesForm(
      formChange: _handleGameFormChange,
    );

    super.initState();
  }

  /// Upload in the service the image of the new establishment
  Future<void> _uploadImage(BigInt id) async {
    if (_imageBytes == null) return;

    final supabase = Supabase.instance.client;
    const folderName = 'establishment-images';
    final fileName = '$id.jpg';
    final filePath = '$folderName/$fileName';

    try {
      await supabase.storage.from('CartoBucket').uploadBinary(
        filePath,
        _imageBytes!,
        fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
      );

    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AJOUTER UN LIEU'),
        backgroundColor: blue,
        titleTextStyle: appBarTextStyle,
        centerTitle: true,
        iconTheme: const IconThemeData(color: white),
      ),
      body:
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffffffff), Color(0xffd4bbf9)],
            stops: [0.7, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
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
                    child: const Text("SUGGÉRER", style: blueTextBold16,),
                    onPressed: () async {

                    if(formIsValid()){
                      BigInt id = await establishmentViewModel.createEstablishment(
                          _name,
                          _address,
                          _site,
                          _description,
                          _nearTransport,
                          _pmrAccess,
                          _gamePrice,
                          _mail,
                          _phoneNumber,
                          _longitude,
                          _latitude,
                          _weekOpeningHour,
                          _games,
                      );
                      _uploadImage(id);
                      Navigator.pushNamed(context, '/thank',);
                    }
                  },
                )
              ),
            ],
          ),
        ]
      )
    ));
  }

  /// Give the sate of validity of the form
  bool formIsValid() {
    return _generalFormIsValid & _contactFormIsValid;
  }

  /// Give the sate of validity of the general form
  void _handleGeneralFormValidity(bool formIsValid) {
    setState(() {
      _generalFormIsValid = formIsValid;
    });
  }

  /// The call back of the general form
  void _handleGeneralFormChange(List<String> newValues) {
    _name = newValues[0];
    _address = newValues[1];
    _latitude = newValues[2];
    _longitude = newValues[3];
    _site = newValues[4];
    _description = newValues[5];
    _gamePrice = PriceEnum.fromString(newValues[6]);
    _nearTransport = newValues[7] == "true";
    _pmrAccess = newValues[8] == "true";
    if(newValues[9]!="null"){
      String listWithoutBracket =
          newValues[9].replaceAll('[', '').replaceAll(']', '');
      List<String> stringList = listWithoutBracket.split(",");
      List<int> intlist = [];
      for (String s in stringList) {
        intlist.add(int.parse(s));
      }
      _imageBytes = Uint8List.fromList(intlist);
    }
  }

  /// Give the sate of validity of the contact form
  void _handleContactFormValidity(bool formIsValid) {
    setState(() {
      _contactFormIsValid = formIsValid;
    });
  }

  /// The call back of the contact form
  void _handleContactFormChange(List<String> newValues) {
    _mail = newValues[0];
    _phoneNumber = newValues[1];
  }

  /// The call back of the opening hour form
  void _handleOpeningHourFormChange(WeekOpening newWeekOpeningHour) {
    _weekOpeningHour = newWeekOpeningHour;
  }

  /// The call back of the game form
  void _handleGameFormChange(EstablishmentGames newGames) {
    _games = newGames;
  }
}