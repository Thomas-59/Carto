import 'package:carto/enum/price_enum.dart';
import 'package:carto/views/widgets/form/form_fields/my_form_field_double.dart';
import 'package:flutter/material.dart';

import 'form_fields/my_form_field.dart';
import 'other_fields/price_button.dart';

class GeneralForm extends StatefulWidget {
  final ValueChanged<bool> formIsValid;
  final ValueChanged<List<String>> formChange;
  final String name, address, latitude, longitude, site, description;
  final PriceEnum gamePrice;
  final bool nearTransport, pmrAccess;

  const GeneralForm({
    super.key,
    required this.formIsValid,
    required this.formChange,
    this.name = "",
    this.address = "",
    this.latitude = "",
    this.longitude = "",
    this.site = "",
    this.description = "",
    this.gamePrice = PriceEnum.medium,
    this.nearTransport = false,
    this.pmrAccess = false,
  });

  @override
  State<GeneralForm> createState() => _GeneralFormState();
}

class _GeneralFormState extends State<GeneralForm> {
  //controller
  late final MyFormField _nameField, _addressField, _latitudeField,
      _longitudeField, _siteField, _descriptionField;

  //checkBox
  late bool _nearTransport = widget.nearTransport,
      _pmrAccess = widget.nearTransport;

  //validator
  late bool _nameIsValid, _addressIsValid, _latitudeIsValid, _longitudeIsValid,
    _siteIsValid, _descriptionIsValid;

  late PriceEnum _gamePrice = widget.gamePrice;

  @override
  void initState() {
    TextEditingController nameController =
      TextEditingController(text: widget.name);
    TextEditingController addressController =
      TextEditingController(text: widget.address);
    TextEditingController latitudeController =
      TextEditingController(text: widget.latitude);
    TextEditingController longitudeController =
      TextEditingController(text: widget.longitude);
    TextEditingController siteController =
      TextEditingController(text: widget.site);
    TextEditingController descriptionController =
      TextEditingController(text: widget.description);


    _nameField = MyFormField(
        label: "Nom d'établissement",
        controller: nameController
    );
    _nameIsValid = _fieldIsValid(_nameField);
    nameController.addListener(() {
      setState(() {
        _nameIsValid = _fieldIsValid(_nameField);
        widget.formIsValid(_formIsValid());
        widget.formChange(getAllParameter());
      });
    });

    _addressField = MyFormField(
        label: "Adresse d'établissement",
        isFeminine: true,
        controller: addressController
    );
    _addressIsValid = _fieldIsValid(_addressField);
    addressController.addListener(() {
      setState(() {
        _addressIsValid = _fieldIsValid(_addressField);
        widget.formIsValid(_formIsValid());
        widget.formChange(getAllParameter());
      });
    });

    _latitudeField = MyFormFieldDouble(
        label: "Latitude d'établissement",
        isFeminine: true,
        controller: latitudeController
    );
    _latitudeIsValid = _fieldIsValid(_latitudeField);
    latitudeController.addListener(() {
      setState(() {
        _latitudeIsValid = _fieldIsValid(_latitudeField);
        widget.formIsValid(_formIsValid());
        widget.formChange(getAllParameter());
      });
    });

    _longitudeField = MyFormFieldDouble(
        label: "Longitude d'établissement",
        isFeminine: true,
        controller: longitudeController
    );
    _longitudeIsValid = _fieldIsValid(_longitudeField);
    longitudeController.addListener(() {
      setState(() {
        _longitudeIsValid = _fieldIsValid(_longitudeField);
        widget.formIsValid(_formIsValid());
        widget.formChange(getAllParameter());
      });
    });

    _siteField = MyFormField(
      label: "Site web d'établissement",
      controller: siteController,
      canBeEmpty: true,
    );
    _siteIsValid = _fieldIsValid(_siteField);
    siteController.addListener(() {
      setState(() {
        _siteIsValid = _fieldIsValid(_siteField);
        widget.formIsValid(_formIsValid());
        widget.formChange(getAllParameter());
      });
    });

    _descriptionField = MyFormField(
      label: "Description d'établissement",
      isFeminine: true,
      controller: descriptionController,
      maxLines: 10,
      canBeEmpty: true,
    );
    _descriptionIsValid = _fieldIsValid(_descriptionField);
    descriptionController.addListener(() {
      setState(() {
        _descriptionIsValid = _fieldIsValid(_longitudeField);
        widget.formIsValid(_formIsValid());
        widget.formChange(getAllParameter());
      });
    });

    super.initState();
  }

  bool _fieldIsValid(MyFormField field) {
    return (field.validator(field.controller.text) == null);
  }

  bool _formIsValid() {
    return _nameIsValid & _addressIsValid & _latitudeIsValid &
      _longitudeIsValid & _siteIsValid & _descriptionIsValid;
  }

  List<String> getAllParameter() {
    return <String> [
      _nameField.controller.text,
      _addressField.controller.text,
      _latitudeField.controller.text,
      _longitudeField.controller.text,
      _siteField.controller.text,
      _descriptionField.controller.text,
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
        _nameField,
        _addressField,
        _latitudeField,
        _longitudeField,
        _siteField,
        _descriptionField,
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