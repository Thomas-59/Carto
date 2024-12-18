import 'package:flutter/material.dart';

class ThankingPage extends StatefulWidget {
  const ThankingPage({super.key});

  @override
  State<ThankingPage> createState() => _ThankingPageState();
}

class _ThankingPageState extends State<ThankingPage> {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            body:
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding( padding: EdgeInsets.fromLTRB(64, 16, 64, 16),
                  child : Text(
                    "Merci de votre\nsuggestion\n!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      //fontFamily: 'OPTIChartresGothic'
                    )
                  )
                ),
                const Padding( padding: EdgeInsets.fromLTRB(32, 16, 32, 32),
                  child : Text(
                    "Votre suggestion prendra un délai pour être examiné"
                    " et être ajouté dans notre base.",
                    textAlign: TextAlign.center,
                  )
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    disabledForegroundColor: Colors.grey.withOpacity(0.38),
                    disabledBackgroundColor: Colors.grey.withOpacity(0.12),
                  ),
                  child: const Text("Retour à la carte"),
                  onPressed: () {
                    Navigator.of(context)..pop()..pop();
                  },
                ),
              ],
            )
          );
        }
    );
  }
}
