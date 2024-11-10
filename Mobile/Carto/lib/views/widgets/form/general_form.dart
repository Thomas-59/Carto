import 'package:carto/enum/price_enum.dart';
import 'package:flutter/material.dart';

import 'form_fields/my_form_field.dart';
import 'other_fields/price_button.dart';

class GeneralForm extends StatefulWidget {
  final ValueChanged<bool> formIsValid;
  final ValueChanged<List<String>> formChange;
  final String name;
  final String address;
  final PriceEnum gamePrice;
  final bool nearTransport;
  final bool pmrAccess;

  const GeneralForm({
    super.key,
    required this.formIsValid,
    required this.formChange,
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
  late final _addressController = TextEditingController(text: widget.address);

  //checkBox
  late bool _nearTransport = widget.nearTransport;
  late bool _pmrAccess = widget.nearTransport;

  //validator
  late bool _nameIsValid;
  late bool _addressIsValid;

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

    super.initState();
  }

  bool _nameValueIsValid(String value) {
    return value.isNotEmpty;
  }
  
  bool _addressValueIsValid(String value) {
    return value.isNotEmpty;
  }

  bool _formIsValid() {
    return _nameIsValid & _addressIsValid;
  }

  List<String> getAllParameter() {
    return <String> [
      _nameController.text,
      _addressController.text,
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
          "Générale",
          style: TextStyle(fontWeight: FontWeight.bold),
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