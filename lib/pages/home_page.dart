import 'package:flutter/material.dart';

import 'language_page.dart';
import '../components/menu_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IntrinsicWidth(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: const Text(
                  'Language Learning',
                  style: TextStyle(fontSize: 35.0),
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(bottom: 75.0),
              ),
              Container(
                child: MenuButton(text: 'Rozpocznij naukę', onPressed: () {}),
                margin: EdgeInsets.symmetric(vertical: 20.0),
              ),
              Container(
                child: MenuButton(
                    text: 'Dodaj nowe słowa lub wyrażenia',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LanguagePage(),
                          ));
                    }),
                margin: EdgeInsets.symmetric(vertical: 20.0),
              ),
              Container(
                child: MenuButton(text: 'Wyjście', onPressed: () {}),
                margin: EdgeInsets.symmetric(vertical: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
