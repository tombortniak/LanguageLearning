import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:language_learning/database/database.dart';
import 'pages/home_page.dart';
import 'components/menu_button.dart';

void main() {
  runApp(Provider<MyDatabase>(
    create: (context) => MyDatabase(),
    child: const LanguageLearningApp(),
    dispose: (context, db) => db.close(),
  ));
}

class LanguageLearningApp extends StatelessWidget {
  const LanguageLearningApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Learning',
      home: const HomePage(),
    );
  }
}
