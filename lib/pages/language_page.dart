import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:language_learning/database/database.dart';

import 'management_page.dart';
import 'package:language_learning/components/language_card.dart';
import 'package:language_learning/constants.dart';
import 'package:provider/provider.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 20.0,
          runSpacing: 20.0,
          children: [
            LanguageCard(
              onTap: () async {
                var phrases =
                    await Provider.of<MyDatabase>(context, listen: false)
                        .getPhrases(Language.spanish);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ManagementPage(
                          language: Language.spanish,
                          specialCharacters: kSpanishSpecialCharacters,
                          initialPhrases: phrases),
                    ));
              },
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
          ],
        ),
      ),
    );
  }
}
