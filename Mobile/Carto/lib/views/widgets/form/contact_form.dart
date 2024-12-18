import 'package:carto/views/widgets/form/form_fields/my_form_field.dart';
import 'package:flutter/material.dart';

import 'form_fields/my_form_field_mail.dart';
import 'form_fields/my_form_field_int.dart';

class ContactForm extends StatefulWidget {
  final ValueChanged<bool> formIsValid;
  final ValueChanged<List<String>> formChange;
  final String mail;
  final String phoneNumber;

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

class _ContactFormState extends State<ContactForm> {
  //controller
  late final MyFormField _mailField;
  late final MyFormField _phoneNumberField;

  //validator
  late bool _mailIsValid;
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

  bool _formIsValid() {
    return _mailIsValid & _phoneNumberIsValid;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Contacts",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.5)
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