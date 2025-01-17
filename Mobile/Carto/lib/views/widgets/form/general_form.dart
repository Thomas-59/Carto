import 'dart:typed_data';

import 'package:carto/enum/price_enum.dart';
import 'package:carto/models/address.dart';
import 'package:carto/views/widgets/constants.dart';
import 'package:carto/views/widgets/form/form_fields/my_form_field_http_link.dart';
import 'package:carto/views/widgets/form/other_fields/my_checkbox_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../pages/address_input_page.dart';
import 'form_fields/my_form_field.dart';
import 'other_fields/price_button.dart';

class GeneralForm extends StatefulWidget {
  final ValueChanged<bool> formIsValid;
  final ValueChanged<List<String>> formChange;
  final String name, address, latitude, longitude, site, description;
  final PriceEnum gamePrice;
  final bool nearTransport, pmrAccess;

  final Uint8List? imageBytes;

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
    this.imageBytes,
  });

  @override
  State<GeneralForm> createState() => _GeneralFormState();
}

class _GeneralFormState extends State<GeneralForm> {
  //controller
  late final MyFormField _nameField,
      _addressField,
      _longitudeField,
      _siteField,
      _descriptionField;

  //checkBox
  late bool _nearTransport = widget.nearTransport,
      _pmrAccess = widget.nearTransport;

  //validator
  late bool _nameIsValid, _addressIsValid, _siteIsValid, _descriptionIsValid;

  late PriceEnum _gamePrice = widget.gamePrice;
  Address? _addressPick;
  String _adressLabel = "";
  String _longitude = "0";
  String _latitude = "0";

  //image
  final ImagePicker _picker = ImagePicker();
  Uint8List? _imageBytes;

  @override
  void initState() {
    TextEditingController nameController =
        TextEditingController(text: widget.name);
    TextEditingController addressController =
        TextEditingController(text: widget.address);
    TextEditingController siteController =
        TextEditingController(text: widget.site);
    TextEditingController descriptionController =
        TextEditingController(text: widget.description);

    _nameField =
        MyFormField(label: "Nom d'établissement", controller: nameController);
    _nameIsValid = _fieldIsValid(_nameField);
    nameController.addListener(() {
      setState(() {
        _nameIsValid = _fieldIsValid(_nameField);
        widget.formIsValid(_formIsValid());
        widget.formChange(getAllParameter());
      });
    });

    _addressIsValid = _addressValueIsValid(_adressLabel);
    _addressField = MyFormField(
        label: "Adresse d'établissement",
        isFeminine: true,
        controller: addressController);
    _addressIsValid = _fieldIsValid(_addressField);
    addressController.addListener(() {
      setState(() {
        _addressIsValid = _fieldIsValid(_addressField);
        widget.formIsValid(_formIsValid());
        widget.formChange(getAllParameter());
      });
    });

    _siteField = MyFormFieldHttpLink(
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
    return (field.validator(field.getValue()) == null);
  }

  bool _addressValueIsValid(String value) {
    return value.isNotEmpty;
  }

  bool _formIsValid() {
    return _nameIsValid & _addressIsValid & _siteIsValid & _descriptionIsValid;
  }

  List<String> getAllParameter() {
    return <String>[
      _nameField.getValue(),
      _adressLabel,
      _latitude,
      _longitude,
      _siteField.getValue(),
      _descriptionField.getValue(),
      _gamePrice.value,
      _nearTransport.toString(),
      _pmrAccess.toString(),
      _imageBytes.toString()
    ];
  }

  void _openAddressInputPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddressInputPage(
            initialAddress: _addressPick,
            onAddressValidated: (updatedAddress, latitude, longitude) {
              setState(() {
                _addressPick = updatedAddress;
                if (updatedAddress != null) {
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

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      var toStore = Uint8List.fromList(await pickedFile.readAsBytes());
      setState(() {
        _imageBytes = toStore;
        widget.formChange(getAllParameter());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text(
        "INFORMATIONS GÉNÉRALES",
        style: blackTextBold20,
      ),
      const Divider(color: Colors.black),
      _nameField,
      FractionallySizedBox(
        alignment: Alignment.center,
        widthFactor: 0.8,
        child: ElevatedButton(
          onPressed: () {
            _openAddressInputPage();
          },
          style: ButtonStyle(
            backgroundColor: _addressPick != null
                ? const WidgetStatePropertyAll<Color>(Colors.greenAccent)
                : const WidgetStatePropertyAll(Colors.redAccent),
          ),
          child: Text(
            _addressPick != null
                ? _addressPick!.properties.label
                : "Choisir une adresse",
            style: _addressPick != null
                ? null
                : whiteTextBold16,
          ),
        ),
      ),
      _siteField,
      _descriptionField,
      PriceButton(
        text: "Prix moyen des jeux",
        averageGamePrice: _gamePrice,
        onPriceChanged: _handlePriceChange,
      ),
      MyCheckboxListTile(
          value: _nearTransport,
          textColor: black,
          title: "Proche des transports",
          onChanged: (newValue) {
            setState(() {
              _nearTransport = newValue ?? _nearTransport;
              widget.formChange(getAllParameter());
            });
          }),
      MyCheckboxListTile(
          value: _pmrAccess,
          textColor: black,
          title: "Accès personne à mobilité réduite",
          onChanged: (newValue) {
            setState(() {
              _pmrAccess = newValue ?? _pmrAccess;
              widget.formChange(getAllParameter());
            });
          }),
      Column(
        children: [
          OutlinedButton(
            onPressed: _pickImage,
            style: OutlinedButton.styleFrom(
              backgroundColor: blue,
            ),
            child: const Text('Choisir une image', style: whiteTextBold16),
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
              ],
            ),
        ],
      )
    ]);
  }

  void _handlePriceChange(PriceEnum newPrice) {
    setState(() {
      _gamePrice = newPrice;
      widget.formChange(getAllParameter());
    });
  }
}
