import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:language_learning/models/language_element_data.dart';
import 'package:language_learning/pages/learning_options_page.dart';
import 'package:language_learning/pages/settings_page.dart';
import 'language_selection_page.dart';
import 'package:language_learning/constants.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FToast? fToast;

  @override
  void initState() {
    fToast = FToast();
    fToast!.init(context);
    super.initState();
  }

  void showMessage(MessageType messageType, String message) {
    Color backgroundColor;
    Color textColor;
    IconData iconData;
    if (messageType == MessageType.error) {
      backgroundColor = Colors.redAccent;
      textColor = Colors.white;
      iconData = Icons.error;
    } else {
      backgroundColor = Colors.greenAccent;
      textColor = Colors.black;
      iconData = Icons.check;
    }
    fToast?.showToast(
        gravity: ToastGravity.BOTTOM,
        child: Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: backgroundColor),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconData,
                color: textColor,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: textColor),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'language learning',
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
                  width: 100.0,
                  height: 100.0,
                  margin: const EdgeInsets.all(5.0),
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
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  if (Provider.of<LanguageElementData>(context, listen: false)
                      .languages
                      .isEmpty) {
                    showMessage(MessageType.error, 'Brak dodanych języków');
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LearningOptionsPage(),
                        ));
                  }
                },
              ),
              ElevatedButton(
                child: Container(
                  width: 100.0,
                  height: 100.0,
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
                        style: Theme.of(context).textTheme.headline5,
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
                  width: 100.0,
                  height: 100.0,
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
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(),
                      ));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
