import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                onTap: () {},
                text: 'hiszpański',
                image: Image.asset(
                  'images/spain.png',
                ),
              ),
              LanguageCard(
                onTap: () {},
                text: 'angielski',
                image: Image.asset(
                  'images/great_britain.png',
                ),
              ),
              LanguageCard(
                onTap: () {},
                image: Icon(
                  FontAwesomeIcons.plusCircle,
                  size: 50.0,
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
