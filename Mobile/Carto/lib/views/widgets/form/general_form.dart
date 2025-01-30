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

/// The frame concerning the general information of the establishment in the form
class GeneralForm extends StatefulWidget {
  /// The action to take when validity of the frame change
  final ValueChanged<bool> formIsValid;
  /// The action to take when value change
  final ValueChanged<List<String>> formChange;
  /// The initial name of the establishment
  final String name,
  /// The initial address of the establishment
    address,
  /// The initial latitude of the establishment
    latitude,
  /// The initial longitude of the establishment
    longitude,
  /// The initial web site of the establishment
    site,
  /// The initial description of the establishment
    description;
  /// The initial average price of the establishment
  final PriceEnum gamePrice;
  /// The initial state if the establishment is near public transport
  final bool nearTransport,
  /// The initial state if the establishment  have pmr access
    pmrAccess;

  /// The initial image of the establishment
  final Uint8List? imageBytes;

  /// The initializer of the class
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

/// The state of GeneralForm
class _GeneralFormState extends State<GeneralForm> {
  //controller
  /// The form field of the establishment name
  late final MyFormField _nameField,
  /// The form field of the establishment address
      _addressField,
  /// The form field of the establishment website
      _siteField,
  /// The form field of the establishment description
      _descriptionField;

  //checkBox
  /// If the establishment is near public transport
  late bool _nearTransport = widget.nearTransport,
  /// If the establishment have pmr access
    _pmrAccess = widget.pmrAccess;

  //validator
  /// The validity of the name field
  late bool _nameIsValid,
  /// The validity of the address field
    _addressIsValid,
  /// The validity of the web site field
    _siteIsValid;

  /// The average price of game in the establishment
  late PriceEnum _gamePrice = widget.gamePrice;
  /// The model of the chosen address
  Address? _addressPick;
  /// The address name of the establishment
  String _addressLabel = "";
  /// The longitude of the establishment
  String _longitude = "0";
  /// The latitude of the establishment
  String _latitude = "0";

  //image
  /// The instance of the class to pick image
  final ImagePicker _picker = ImagePicker();
  /// The image given to the establishment
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

    _addressIsValid = _addressValueIsValid(_addressLabel);
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

    super.initState();
  }

  /// Give the validity of the value for the text field
  bool _fieldIsValid(MyFormField field) {
    return (field.validator(field.getValue()) == null);
  }

  /// Give the validity of the value for the address field
  bool _addressValueIsValid(String value) {
    return value.isNotEmpty;
  }

  /// Give the validity state of the form frame
  bool _formIsValid() {
    return _nameIsValid & _addressIsValid & _siteIsValid;
  }

  /// Give a list of all field in the frame
  List<String> getAllParameter() {
    return <String>[
      _nameField.getValue(),
      _addressLabel,
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

  /// Open the page to the address search page
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
                  _addressLabel = updatedAddress.properties.label;
                }
                _latitude = latitude;
                _longitude = longitude;
                _addressIsValid = _addressValueIsValid(_addressLabel);
                widget.formIsValid(_formIsValid());
                widget.formChange(getAllParameter());
              });
            },
          ),
        ));
  }

  /// Pike a ime from the phone gallery of the user
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

  /// The action to take on change of average price
  void _handlePriceChange(PriceEnum newPrice) {
    setState(() {
      _gamePrice = newPrice;
      widget.formChange(getAllParameter());
    });
  }
}
