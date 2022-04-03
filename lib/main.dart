import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:language_learning/models/language_element_data.dart';
import 'package:language_learning/pages/home_page.dart';
import 'package:language_learning/pages/splash_page.dart';
import 'database/database.dart';

import 'package:provider/provider.dart';
import 'package:language_learning/database/database.dart';
import 'theme.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(
    MultiProvider(
      providers: [
        Provider<LanguageDatabase>(
          create: (context) => LanguageDatabase(),
          dispose: (context, db) => db.close(),
        ),
        ChangeNotifierProvider<LanguageElementData>(
          create: (context) => LanguageElementData(context: context),
        )
      ],
      child: const LanguageLearningApp(),
    ),
  );
}

class LanguageLearningApp extends StatelessWidget {
  const LanguageLearningApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Learning',
      home: SplashPage(),
      darkTheme: LanguageLearningTheme.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
    );
  }
}
