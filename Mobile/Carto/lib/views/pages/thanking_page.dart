import 'package:carto/views/widgets/buttons.dart';
import 'package:carto/views/widgets/constants.dart';
import 'package:flutter/material.dart';

class ThankingPage extends StatefulWidget {
  const ThankingPage({super.key});

  @override
  State<ThankingPage> createState() => _ThankingPageState();
}

class _ThankingPageState extends State<ThankingPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
          backgroundColor: purple,
          body: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                      padding: EdgeInsets.fromLTRB(64, 16, 64, 16),
                      child: Text("Merci de votre\nsuggestion !",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: black))),
                  const Padding(
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 32),
                      child: Text(
                        "Votre suggestion prendra un délai pour être examiné"
                        " et être ajouté dans notre base.",
                        textAlign: TextAlign.center,
                        style: textInPageTextStyle,
                      )),
                  LargeDefaultElevatedButton(
                    title: "Retour à la carte",
                    onPressed: () {
                      Navigator.of(context)
                        ..pop()
                        ..pop();
                    },
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  "assets/images/PERSO_CARTO/PERSO4.png",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ));
    });
  }
}
