import 'package:flutter/material.dart';

import 'package:language_learning/components/menu_button.dart';
import 'package:language_learning/components/language_card.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Wrap(
            spacing: 20.0,
            children: [
              LanguageCard(
                text: 'spanish',
                flag: Image.asset(
                  'images/spain.png',
                  height: 150,
                  width: 150,
                ),
              ),
              LanguageCard(
                text: 'english',
                flag: Image.asset(
                  'images/great_britain.png',
                  height: 150,
                  width: 150,
                ),
              ),
            ],
          ),
          MenuButton(
              text: 'Powrót',
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      )),
    );
  }
}
