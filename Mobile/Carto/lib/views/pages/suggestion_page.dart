import 'package:flutter/material.dart';

import '../widgets/form/contact_form.dart';
import '../widgets/form/general_form.dart';

class SuggestionPage extends StatefulWidget {
  const SuggestionPage({super.key});

  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  late Widget generalForm;
  late Widget contactForm;

  bool generalFormIsValid = false;
  bool contactFormIsValid = false;

  @override
  void initState() {
    generalForm = GeneralForm(formIsValid: _handleGeneralFormChange);
    contactForm = ContactForm(formIsValid: _handleContactFormChange);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          generalForm,
          contactForm,
          ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: formIsValid() ? Colors.white : Colors.grey,
            disabledForegroundColor: Colors.grey.withOpacity(0.38),
            disabledBackgroundColor: Colors.grey.withOpacity(0.12),
           ),
            child: const Text("Suggérer un établissement"),
            onPressed: () {
              formIsValid() ?
              Navigator.pushNamed(context, '/',)
              : null;
            },
          ),
        ],
      ),
    );
  }

  bool formIsValid() {
    return generalFormIsValid & contactFormIsValid;
  }

  void _handleGeneralFormChange(bool formIsValid) {
    setState(() {
      generalFormIsValid = formIsValid;
    });
  }

  void _handleContactFormChange(bool formIsValid) {
    setState(() {
      contactFormIsValid = formIsValid;
    });
  }
}