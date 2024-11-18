import 'package:carto/enum/price_enum.dart';
import 'package:carto/views/widgets/form/form_fields/my_form_field_coordinate.dart';
import 'package:flutter/material.dart';

import 'form_fields/my_form_field.dart';
import 'other_fields/price_button.dart';

class GeneralForm extends StatefulWidget {
  final ValueChanged<bool> formIsValid;
  final ValueChanged<List<String>> formChange;
  final String name;
  final String address;
  final String latitude;
  final String longitude;
  final PriceEnum gamePrice;
  final bool nearTransport;
  final bool pmrAccess;

  const GeneralForm({
    super.key,
    required this.formIsValid,
    required this.formChange,
    this.name = "",
    this.address = "",
    this.latitude = "",
    this.longitude = "",
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
  late final _addressController = TextEditingController(text: widget.address);
  late final _latitudeController =
    TextEditingController(text: widget.latitude);
  late final _longitudeController =
    TextEditingController(text: widget.longitude);

  //checkBox
  late bool _nearTransport = widget.nearTransport;
  late bool _pmrAccess = widget.nearTransport;

  //validator
  late bool _nameIsValid;
  late bool _addressIsValid;
  late bool _latitudeIsValid;
  late bool _longitudeIsValid;

  late PriceEnum _gamePrice = widget.gamePrice;

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

    _addressIsValid = _addressValueIsValid(_addressController.text);
    _addressController.addListener(() {
      setState(() {
        _addressIsValid = _addressValueIsValid(_addressController.text);
        widget.formIsValid(_formIsValid());
        widget.formChange(getAllParameter());
      });
    });

    _latitudeIsValid = _coordinatesValueIsValid(widget.latitude);
    _latitudeController.addListener(() {
      setState(() {
        _latitudeIsValid =
            _coordinatesValueIsValid(_latitudeController.text);
        widget.formIsValid(_formIsValid());
        widget.formChange(getAllParameter());
      });
    });

    _longitudeIsValid = _coordinatesValueIsValid(widget.longitude);
    _longitudeController.addListener(() {
      setState(() {
        _longitudeIsValid =
            _coordinatesValueIsValid(_longitudeController.text);
        widget.formIsValid(_formIsValid());
        widget.formChange(getAllParameter());
      });
    });

    super.initState();
  }

  bool _nameValueIsValid(String value) {
    return value.isNotEmpty;
  }
  
  bool _addressValueIsValid(String value) {
    return value.isNotEmpty;
  }

  bool _coordinatesValueIsValid(String value) {
    try {
      double.parse(value);
    } catch (e) {
      return false;
    }
    return value.isNotEmpty;
  }

  bool _formIsValid() {
    return _nameIsValid & _addressIsValid & _latitudeIsValid &
      _longitudeIsValid;
  }

  List<String> getAllParameter() {
    return <String> [
      _nameController.text,
      _addressController.text,
      _latitudeController.text,
      _longitudeController.text,
      _gamePrice.value,
      _nearTransport.toString(),
      _pmrAccess.toString()
    ];
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
        MyFormField(
            label: "Adresse d'établissement",
            isFeminine: true,
            controller: _addressController
        ),
        MyFormFieldCoordinate(
            label: "Latitude d'établissement",
            isFeminine: true,
            controller: _latitudeController
        ),
        MyFormFieldCoordinate(
            label: "Longitude d'établissement",
            isFeminine: true,
            controller: _longitudeController
        ),
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