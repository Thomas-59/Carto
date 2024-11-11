import 'package:flutter/material.dart';

import 'form_fields/my_form_field_mail.dart';
import 'form_fields/my_form_field_num.dart';

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
  late final _mailController = TextEditingController(text: widget.mail);
  late final _phoneNumberController =
    TextEditingController(text: widget.phoneNumber);

  //validator
  late bool _mailIsValid;
  late bool _phoneNumberIsValid;

  @override
  void initState() {

    _mailIsValid = _mailValueIsValid(_mailController.text);
    _mailController.addListener(() {
      setState(() {
        _mailIsValid = _mailValueIsValid(_mailController.text);
        widget.formIsValid(_formIsValid());
        widget.formChange(<String> [_mailController.text,
          _phoneNumberController.text]);
      });
    });

    _phoneNumberIsValid = _phoneNumberValueIsValid(widget.phoneNumber);
    _phoneNumberController.addListener(() {
      setState(() {
        _phoneNumberIsValid =
            _phoneNumberValueIsValid(_phoneNumberController.text);
        widget.formIsValid(_formIsValid());
        widget.formChange(<String> [_mailController.text,
          _phoneNumberController.text]);
      });
    });


    super.initState();
  }

  bool _mailValueIsValid(String value) {
    return value.isNotEmpty;
  }

  bool _phoneNumberValueIsValid(String value) {
    if (value == "") {
      return true;
    } else {
      try {
        int.parse(value);
        return true;
      } catch (e) {
        return false;
      }
    }
  }

  bool _formIsValid() {
    return _mailIsValid & _phoneNumberIsValid;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Contacte",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.5)
        ),
        const Divider(
            color: Colors.black
        ),
        MyFormFieldMail(
            label: "Mail d'établissement",
            isFeminine: false,
            controller: _mailController
        ),
        MyFormFieldNum(
            label: "Téléphone d'établissement",
            isFeminine: false,
            controller: _phoneNumberController
        ),
      ],
    );
  }
}