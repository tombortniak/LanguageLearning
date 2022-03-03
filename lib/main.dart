import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'components/menu_button.dart';

void main() {
  runApp(const LanguageLearningApp());
}

class LanguageLearningApp extends StatelessWidget {
  const LanguageLearningApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LanguageLearning',
      home: const HomePage(),
    );
  }
}
