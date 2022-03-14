import 'package:flutter/material.dart';
import 'language_page.dart';
import 'package:language_learning/components/language_card.dart';
import 'package:language_learning/constants.dart';

class LanguageSelectionPage extends StatelessWidget {
  const LanguageSelectionPage({Key? key}) : super(key: key);

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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LanguagePage(
                      language: Language.spanish,
                      specialCharacters: kSpanishSpecialCharacters,
                    ),
                  ),
                );
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
