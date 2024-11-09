import 'package:flutter/material.dart';

import 'form_fields/my_form_field_mail.dart';
import 'form_fields/my_form_field_num.dart';

class ContactForm extends StatefulWidget {
  final ValueChanged<bool> formIsValid;

  const ContactForm({super.key, required this.formIsValid});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  //controller
  final mailController = TextEditingController(text: "");
  final tellController = TextEditingController(text: "");

  //validator
  bool mailValid = false;
  bool tellValid = true;

  @override
  void initState() {

    mailController.addListener(() {
      setState(() {
        mailValid = mailController.text.isNotEmpty;
        widget.formIsValid(formIsValid());
      });
    });

    tellController.addListener(() {
      setState(() {
        if (tellController.text == "") {
          tellValid = true;
        } else {
          try {
            int.parse(tellController.text);
            tellValid = true;
          } catch (e) {
            tellValid = false;
          }
        }
        widget.formIsValid(formIsValid());
      });
    });

    super.initState();
  }

  bool formIsValid() {
    return mailValid & tellValid;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Contacte",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const Divider(
            color: Colors.black
        ),
        MyFormFieldMail(label: "mail d'établissement", isFeminine: false, controller: mailController),
        MyFormFieldNum(label: "téléphone d'établissement", isFeminine: false, controller: tellController),
      ],
    );
  }
}