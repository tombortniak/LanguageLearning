import 'package:flutter/material.dart';
import 'package:language_learning/constants.dart';
import 'package:language_learning/database/database.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class ElementData extends ChangeNotifier {
  List<Word> _words = [];
  List<Verb> _verbs = [];
  List<Phrase> _phrases = [];

  Future getElements(BuildContext context, Language language,
      LanguageElement languageElement) async {
    var elements = await Provider.of<LanguageDatabase>(context, listen: false)
        .getElements(language, languageElement);
    return elements;
  }
}
