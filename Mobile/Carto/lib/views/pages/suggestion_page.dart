import 'dart:convert';
import 'dart:typed_data';

import 'package:carto/enum/price_enum.dart';
import 'package:carto/viewmodel/establishment_view_model.dart';
import 'package:carto/views/widgets/form/games_form.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../services/establishment_service.dart';
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
  bool _contactFormIsValid = true;

  // GeneralForm
  late String _name, _address, _latitude, _longitude, _site, _description;
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

  // Service
  EstablishmentViewModel establishmentViewModel = EstablishmentViewModel();
  EstablishmentService establishmentService = EstablishmentService();

  //image
  late Uint8List? _imageBytes;
  bool _isUploading= false;
  String? _uploadedImageUrl;

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

  Future<void> _uploadImage(BigInt id) async {
    if (_imageBytes == null) return;

    setState(() {
      _isUploading = true;
    });

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

      final publicUrl =
        supabase.storage.from('CartoBucket').getPublicUrl(filePath);

      setState(() {
        _uploadedImageUrl = publicUrl;
        _isUploading = false;
      });
    } catch (error) {
      setState(() {
        _isUploading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $error')),
      );
    }
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
                  onPressed: () async {

                    if(formIsValid()){
                      //BigInt id = await establishmentService.createEstablishment(establishment);
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
                          _weekOpening,
                          _gameTitles,
                          _gameNumbers
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