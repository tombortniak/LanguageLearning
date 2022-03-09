import 'package:flutter/material.dart';

import 'package:drift/drift.dart' as drift;
import 'package:provider/provider.dart';
import 'package:language_learning/database/database.dart';
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
                child: Text(
                  'Language Learning',
                  style: Theme.of(context).textTheme.headline1,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(bottom: 75.0),
              ),
              Container(
                child: MenuButton(
                    text: 'Rozpocznij naukę', onPressed: () async {}),
                margin: EdgeInsets.symmetric(vertical: 20.0),
              ),
              Container(
                child: MenuButton(
                    text: 'Zarządzaj językami',
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
