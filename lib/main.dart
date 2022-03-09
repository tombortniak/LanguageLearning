import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:language_learning/database/database.dart';
import 'pages/home_page.dart';
import 'theme.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
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
      home: HomePage(),
      darkTheme: LanguageLearningTheme.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}
