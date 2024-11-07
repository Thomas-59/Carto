import 'package:carto/enum/price_enum.dart';
import 'package:flutter/material.dart';

import 'form_fields/my_form_field.dart';
import 'form_fields/price_button.dart';

class GeneralForm extends StatefulWidget {
  final ValueChanged<bool> formIsValid;

  const GeneralForm({super.key, required this.formIsValid});

  @override
  State<GeneralForm> createState() => _GeneralFormState();
}

class _GeneralFormState extends State<GeneralForm> {
  //controller
  final nomController = TextEditingController(text: "");
  final addressController = TextEditingController(text: "");

  //checkBox
  bool nearTransport = false;
  bool pmrAccess = false;

  //validator
  bool nomValid = false;
  bool addressValid = false;

  PriceEnum gamePrice = PriceEnum.medium;

  @override
  void initState() {
    nomController.addListener(() {
      setState(() {
        nomValid = nomController.text.isNotEmpty;
        widget.formIsValid(formIsValid());
      });
    });

    addressController.addListener(() {
      setState(() {
        addressValid = addressController.text.isNotEmpty;
        widget.formIsValid(formIsValid());
      });
    });

    super.initState();
  }

  bool formIsValid() {
    return nomValid & addressValid;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Générale"),
        const Divider(
            color: Colors.black
        ),
        MyFormField(label: "nom d'établissement", isFeminine: false, controller: nomController),
        MyFormField(label: "adresse d'établissement", isFeminine: true, controller: addressController),
        PriceButton(text: "prix moyen des jeux", averageGamePrice: gamePrice, onPriceChanged: _handlePriceChange,),
        generalOption(),
      ],
    );
  }

  void _handlePriceChange(PriceEnum newPrice) {
    setState(() {
      gamePrice = newPrice;
    });
  }

  Widget generalOption() {
    return Column(
      children: [
        CheckboxListTile(value: nearTransport,
            controlAffinity: ListTileControlAffinity.leading,
            title: const Text("proche des transports"),
            onChanged:(newValue){
              setState(() {
                nearTransport = newValue ?? nearTransport;
              });
            }),
        CheckboxListTile(value: pmrAccess,
            controlAffinity: ListTileControlAffinity.leading,
            title: const Text("Accès PMR"),
            onChanged:(newValue){
              setState(() {
                pmrAccess = newValue ?? pmrAccess;
              });
            }),
      ],
    );
  }
}