import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:language_learning/constants.dart' hide Language;
import 'package:language_learning/database/database.dart';
import 'package:tuple/tuple.dart';
import 'package:provider/provider.dart';
import 'package:language_learning/database/database.dart';

class LanguageElementData extends ChangeNotifier {
  List<Word> words = [];
  List<Verb> verbs = [];
  List<Phrase> phrases = [];
  List<Category> categories = [];
  List<Language> languages = [];

  BuildContext context;

  LanguageElementData({required this.context});

  void initalize(
      Tuple5<List<Word>, List<Verb>, List<Phrase>, List<Category>,
              List<Language>>
          elements) {
    words = elements.item1;
    verbs = elements.item2;
    phrases = elements.item3;
    categories = elements.item4;
    languages = elements.item5;
  }

  Future addCategory(CategoriesCompanion category) async {
    var row = await context.read<LanguageDatabase>().addCategory(category);
    categories.add(row);
    notifyListeners();
  }

  Future addLanguage(LanguagesCompanion language) async {
    var row = await context.read<LanguageDatabase>().addLanguage(language);
    languages.add(row);
    notifyListeners();
  }

  Future addElement(dynamic element, LanguageElement languageElement) async {
    if (languageElement == LanguageElement.word) {
      var row = await context.read<LanguageDatabase>().addWord(element);
      words.add(row);
    } else if (languageElement == LanguageElement.verb) {
      var row = await context.read<LanguageDatabase>().addVerb(element);
      verbs.add(row);
    } else {
      final row = await context
          .read<LanguageDatabase>()
          .addPhrase(element as PhrasesCompanion);
      phrases.add(row);
    }
    notifyListeners();
  }

  Future updateElement(dynamic element, LanguageElement languageElement) async {
    if (languageElement == LanguageElement.word) {
      await context.read<LanguageDatabase>().updateWord(element);
      words[words.indexWhere((e) => e.id == (element as Word).id)] =
          element as Word;
    } else if (languageElement == LanguageElement.verb) {
      await context.read<LanguageDatabase>().updateVerb(element);
      verbs[verbs.indexWhere((e) => e.id == (element as Verb).id)] =
          element as Verb;
    } else {
      await context.read<LanguageDatabase>().updatePhrase(element);
      phrases[phrases.indexWhere((e) => e.id == (element as Word).id)] =
          element as Phrase;
    }
    notifyListeners();
  }

  Future removeElement(dynamic element, LanguageElement languageElement) async {
    if (languageElement == LanguageElement.word) {
      await context.read<LanguageDatabase>().removeWord(element as Word);
      words.removeWhere((e) => e.id == element.id);
    } else if (languageElement == LanguageElement.verb) {
      await context.read<LanguageDatabase>().removeVerb(element as Verb);
      verbs.removeWhere((e) => e.id == element.id);
    } else {
      await context.read<LanguageDatabase>().removePhrase(element as Phrase);
      phrases.removeWhere((e) => e.id == element.id);
    }
    notifyListeners();
  }

  List<Category> getCategories() {
    return categories;
  }

  List<dynamic> getElements(LanguageElement languageElement) {
    if (languageElement == LanguageElement.word) {
      return words;
    } else if (languageElement == LanguageElement.verb) {
      return verbs;
    } else {
      return phrases;
    }
  }

  List<Word> getWords(Language language) {
    return words.where((element) => element.language == language.id).toList();
  }

  List<Verb> getVerbs(Language language) {
    return verbs.where((element) => element.language == language.id).toList();
  }

  List<Phrase> getPhrases(Language language) {
    return phrases.where((element) => element.language == language.id).toList();
  }

  void filter(String query, LanguageElement languageElement) {
    if (languageElement == LanguageElement.word) {
      filterWords(query);
    } else if (languageElement == LanguageElement.verb) {
      filterVerbs(query);
    } else {
      filterPhrases(query);
    }
    notifyListeners();
  }

  List<Category> filterCategories(String query) {
    return categories.where((element) => element.name.contains(query)).toList();
  }

  void filterWords(String query) {
    words.clear();
    words.addAll(words
        .where((element) => element.content.toLowerCase().contains(query))
        .toList());
  }

  void filterVerbs(String query) {
    verbs.clear();
    verbs.addAll(verbs
        .where((element) => element.content.toLowerCase().contains(query))
        .toList());
  }

  void filterPhrases(String query) {
    phrases.clear();
    phrases.addAll(phrases
        .where((element) => element.content.toLowerCase().contains(query))
        .toList());
  }

  bool containsCategory(String query) {
    return categories.any((element) => element.name == query);
  }

  bool contains(String query, LanguageElement languageElement) {
    if (languageElement == LanguageElement.word) {
      return words.any((e) => e.content == query);
    } else if (languageElement == LanguageElement.verb) {
      return verbs.any((e) => e.content == query);
    } else {
      return phrases.any((e) => e.content == query);
    }
  }
}
