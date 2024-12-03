import 'package:carto/enum/price_enum.dart';
import 'package:carto/models/address.dart';
import 'package:flutter/material.dart';

import '../../pages/address_input_page.dart';
import 'form_fields/my_form_field.dart';
import 'other_fields/price_button.dart';

class GeneralForm extends StatefulWidget {
  final ValueChanged<bool> formIsValid;
  final ValueChanged<List<String>> formChange;
  final String longitude;
  final String latitude;
  final String name;
  final String address;
  final PriceEnum gamePrice;
  final bool nearTransport;
  final bool pmrAccess;


  const GeneralForm({
    super.key,
    required this.formIsValid,
    required this.formChange,
    this.latitude = "",
    this.longitude = "",
    this.name = "",
    this.address = "",
    this.gamePrice = PriceEnum.medium,
    this.nearTransport = false,
    this.pmrAccess = false,
  });

  @override
  State<GeneralForm> createState() => _GeneralFormState();
}

class _GeneralFormState extends State<GeneralForm> {
  //controller
  late final _nameController = TextEditingController(text: widget.name);

  //checkBox
  late bool _nearTransport = widget.nearTransport;
  late bool _pmrAccess = widget.nearTransport;

  //validator
  late bool _nameIsValid;
  late bool _addressIsValid;

  late PriceEnum _gamePrice = widget.gamePrice;
  Address? _addressPick;
  String _adressLabel="";
  String _longitude="0";
  String _latitude="0";
  @override
  void initState() {
    _nameIsValid = _nameValueIsValid(_nameController.text);
    _nameController.addListener(() {
      setState(() {
        _nameIsValid = _nameValueIsValid(_nameController.text);
        widget.formIsValid(_formIsValid());
        widget.formChange(getAllParameter());
      });
    });

    _addressIsValid = _addressValueIsValid(_adressLabel);
    super.initState();
  }

  bool _nameValueIsValid(String value) {
    return value.isNotEmpty;
  }

  bool _addressValueIsValid(String value) {
    print(value);
    return value.isNotEmpty;
  }

  bool _formIsValid() {
    return _nameIsValid & _addressIsValid;
  }

  List<String> getAllParameter() {
    return <String> [
      _nameController.text,
      _adressLabel,
      _latitude,
      _longitude,
      _gamePrice.value,
      _nearTransport.toString(),
      _pmrAccess.toString()
    ];
  }

  void _openAddressInputPage(){
    Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => AddressInputPage(
      initialAddress: _addressPick,
      onAddressValidated: (updatedAddress, latitude, longitude) {
        setState(() {
          _addressPick = updatedAddress;
          if(updatedAddress!=null){
            _adressLabel = updatedAddress.properties.label;
          }
          _latitude = latitude;
          _longitude = longitude;
          _addressIsValid = _addressValueIsValid(_adressLabel);
          widget.formIsValid(_formIsValid());
          widget.formChange(getAllParameter());
        });
      },
    ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Informations générales",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.5),
        ),
        const Divider(
            color: Colors.black
        ),
        MyFormField(
            label: "Nom d'établissement",
            isFeminine: false,
            controller: _nameController
        ),
        ElevatedButton(
            onPressed: () {
              _openAddressInputPage();
            },
            style: ButtonStyle(
              backgroundColor:_addressPick!=null ? WidgetStatePropertyAll<Color>(Colors.greenAccent):WidgetStatePropertyAll<Color>(Colors.redAccent),
            ),
            child: Text(
              _addressPick!=null ? _addressPick!.properties.label : "Choisir une adresse",
            ),
        ),
        // Suggestions
        PriceButton(
          text: "Prix moyen des jeux",
          averageGamePrice: _gamePrice,
          onPriceChanged: _handlePriceChange,
        ),
        CheckboxListTile(
            value: _nearTransport,
            controlAffinity: ListTileControlAffinity.leading,
            title: const Text("Proche des transports"),
            onChanged:(newValue){
              setState(() {
                _nearTransport = newValue ?? _nearTransport;
                widget.formChange(getAllParameter());
              });
            }),
        CheckboxListTile(
            value: _pmrAccess,
            controlAffinity: ListTileControlAffinity.leading,
            title: const Text("Accès PMR"),
            onChanged:(newValue){
              setState(() {
                _pmrAccess = newValue ?? _pmrAccess;
                widget.formChange(getAllParameter());
              });
            }),
      ],
    );
  }

  void _handlePriceChange(PriceEnum newPrice) {
    setState(() {
      _gamePrice = newPrice;
      widget.formChange(getAllParameter());
    });
  }
}