import 'package:carto/views/widgets/form/signup_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(children: [
            const Text(
              "Inscription",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.5),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                child: SignUpForm()),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
              child: GestureDetector(
                onTap: () {
                  // TODO : go to login page
                },
                child: Text("J'ai déjà un compte"),
              ),
            )
          ])
        ],
      ),
    );
  }
}
