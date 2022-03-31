import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:language_learning/pages/learning_options_page.dart';
import 'language_selection_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Language Learning',
            style: Theme.of(context).textTheme.headline1,
            textAlign: TextAlign.center,
          ),
          Wrap(
            runAlignment: WrapAlignment.center,
            alignment: WrapAlignment.center,
            spacing: 5.0,
            runSpacing: 5.0,
            children: [
              ElevatedButton(
                child: Container(
                  width: 110.0,
                  height: 110.0,
                  margin: EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.book,
                        size: 35.0,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Rozpocznij naukę',
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LearningOptionsPage(),
                      ));
                },
              ),
              ElevatedButton(
                child: Container(
                  width: 110.0,
                  height: 110.0,
                  margin: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.language,
                        size: 35.0,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Zarządzaj językami',
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LanguageSelectionPage(),
                      ));
                },
              ),
              ElevatedButton(
                child: Container(
                  width: 110.0,
                  height: 110.0,
                  margin: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.hammer,
                        size: 35.0,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Ustawienia',
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                onPressed: () {},
              ),
              ElevatedButton(
                child: Container(
                  width: 110.0,
                  height: 110.0,
                  margin: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.doorOpen,
                        size: 35.0,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Wyjście',
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                onPressed: () {},
              )
            ],
          ),
        ],
      ),
    );
  }
}
