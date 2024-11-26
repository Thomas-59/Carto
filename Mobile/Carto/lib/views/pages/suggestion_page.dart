import 'dart:typed_data';

import 'package:carto/enum/price_enum.dart';
import 'package:carto/models/establishment.dart';
import 'package:carto/models/establishment_data.dart';
import 'package:carto/views/services/establishment_service.dart';
import 'package:carto/views/widgets/form/games_form.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  // Service
  EstablishmentService establishmentService = EstablishmentService();

  //image
  final ImagePicker _picker = ImagePicker();
  Uint8List? _imageBytes;
  String? _uploadedImageUrl;
  bool _isUploading = false;

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

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      var toStore = Uint8List.fromList(await pickedFile.readAsBytes());
      setState(()  {
        _imageBytes = toStore;
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_imageBytes == null) return;

    setState(() {
      _isUploading = true;
    });

    final supabase = Supabase.instance.client;
    final folderName = 'establishment-images';
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final filePath = '$folderName/$fileName';

    try {
      await supabase.storage.from('CartoBucket').uploadBinary(
        filePath,
        _imageBytes!,
        fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
      );

      final publicUrl = supabase.storage.from('CartoBucket').getPublicUrl(filePath);

      setState(() {
        _uploadedImageUrl = publicUrl;
        _isUploading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image uploaded successfully!')),
      );
    } catch (error) {
      setState(() {
        _isUploading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $error')),
      );
    }
  }

  String convertToString(TimeOfDay time){
    String minRes;
    String hourRes;
    if(time.hour<10){
      hourRes = "0${time.hour}";
    }else{
      hourRes = "${time.hour}";
    }
    if(time.minute<10){
      minRes = "0${time.minute}";
    }else{
      minRes = "${time.minute}";
    }

    return "${hourRes}:${minRes}:00";
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: _pickImage,
                          child: const Text('Pick Image'),
                        ),
                        if (_imageBytes != null)
                          Column(
                            children: [
                              Image.memory(
                                _imageBytes!,
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                              ElevatedButton(
                                onPressed: _isUploading ? null : _uploadImage,
                                child: _isUploading
                                    ? const CircularProgressIndicator()
                                    : const Text('Upload Image'),
                              ),
                            ],
                          ),
                        if (_uploadedImageUrl != null)
                          Text('Uploaded Image URL: $_uploadedImageUrl'),
                      ],
                    ),
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
                          List<DayOfTheWeekElemDto> days = [];
                          days.add(new DayOfTheWeekElemDto(DayOfTheWeek.monday, convertToString(_weekOpeningHour[0][0]), convertToString(_weekOpeningHour[0][1]), _weekOpening[0]));
                          days.add(new DayOfTheWeekElemDto(DayOfTheWeek.tuesday,convertToString(_weekOpeningHour[1][0]), convertToString(_weekOpeningHour[1][1]), _weekOpening[1]));
                          days.add(new DayOfTheWeekElemDto(DayOfTheWeek.wednesday, convertToString(_weekOpeningHour[2][0]), convertToString(_weekOpeningHour[2][1]), _weekOpening[2]));
                          days.add(new DayOfTheWeekElemDto(DayOfTheWeek.thursday, convertToString(_weekOpeningHour[3][0]), convertToString(_weekOpeningHour[3][1]), _weekOpening[3]));
                          days.add(new DayOfTheWeekElemDto(DayOfTheWeek.friday, convertToString(_weekOpeningHour[4][0]), convertToString(_weekOpeningHour[4][1]), _weekOpening[4]));
                          days.add(new DayOfTheWeekElemDto(DayOfTheWeek.saturday, convertToString(_weekOpeningHour[5][0]), convertToString(_weekOpeningHour[5][1]), _weekOpening[5]));
                          days.add(new DayOfTheWeekElemDto(DayOfTheWeek.sunday, convertToString(_weekOpeningHour[6][0]), convertToString(_weekOpeningHour[6][1]), _weekOpening[6]));

                          List<GameTypeDto> games=[];
                          int i =0;
                          while(i<_gameTitles.length-1){
                            if(_gameNumbers[i]>0){
                              games.add(new GameTypeDto(GameType.fromString(_gameTitles[i]), _gameNumbers[i]));
                            }
                            i++;
                          }
                          Establishment establishment = Establishment(
                            null,
                            _name,
                            _address,
                            _nearTransport,
                            _pmrAccess,
                            Price.fromString(_gamePrice.value),
                            _mail,
                            _phoneNumber,
                            double.parse(_longitude),
                            double.parse(_latitude),
                            days,
                            games,
                          );
                          if(formIsValid()){
                            establishmentService.createEstablishment(establishment);
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