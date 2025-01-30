import 'package:carto/views/widgets/constants.dart';
import 'package:carto/views/widgets/form/form_fields/my_form_field.dart';
import 'package:flutter/material.dart';

import 'form_fields/my_form_field_mail.dart';
import 'form_fields/my_form_field_int.dart';

/// The frame concerning the means of contact of the establishment in the form
class ContactForm extends StatefulWidget {
  /// The action to take when validity of the frame change
  final ValueChanged<bool> formIsValid;
  /// The action to take when value change
  final ValueChanged<List<String>> formChange;
  /// The initial mail value
  final String mail;
  /// The initial phone number value
  final String phoneNumber;

  /// The initializer of the class
  const ContactForm({
    super.key,
    required this.formIsValid,
    required this.formChange,
    this.mail = "",
    this.phoneNumber = ""
  });

  @override
  State<ContactForm> createState() => _ContactFormState();
}

/// The state of ContactForm
class _ContactFormState extends State<ContactForm> {
  //controller
  /// The mail form field
  late final MyFormField _mailField;
  /// The phone number form field
  late final MyFormField _phoneNumberField;

  //validator
  /// The state of the mail form field
  late bool _mailIsValid;
  /// The state of the phone number form field
  late bool _phoneNumberIsValid;

  @override
  void initState() {
    TextEditingController mailController = TextEditingController(text: widget.mail);
    TextEditingController phoneNumberController = TextEditingController(text: widget.phoneNumber);

    _mailField = MyFormFieldMail(
      label: "Mail d'établissement",
      controller: mailController,
      canBeEmpty: true,
    );
    _mailIsValid =
      (_mailField.validator(_mailField.getValue()) == null);
    mailController.addListener(() {
      setState(() {
        _mailIsValid = (_mailField.validator(_mailField.getValue()) == null);
        widget.formIsValid(_formIsValid());
        widget.formChange(<String> [_mailField.getValue(),
          _phoneNumberField.getValue()]);
      });
    });

    _phoneNumberField = MyFormFieldInt(
      label: "Téléphone d'établissement",
      controller: phoneNumberController,
      canBeEmpty: true,
    );
    _phoneNumberIsValid =
      (_phoneNumberField.validator(_phoneNumberField.getValue()) == null);
    phoneNumberController.addListener(() {
      setState(() {
        _phoneNumberIsValid =
          (_phoneNumberField.validator(_phoneNumberField.getValue()) == null);
        widget.formIsValid(_formIsValid());
        widget.formChange(<String> [_mailField.getValue(),
          _phoneNumberField.getValue()]);
      });
    });

    super.initState();
  }

  /// Give the validity state of the form frame
  bool _formIsValid() {
    return _mailIsValid & _phoneNumberIsValid;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "CONTACTS",
          style: blackTextBold20,
        ),
        const Divider(
          color: Colors.black
        ),
        _mailField,
        _phoneNumberField,
      ],
    );
  }
}