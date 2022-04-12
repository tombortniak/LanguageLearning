import 'package:flutter/material.dart';
import 'package:language_learning/constants.dart' hide Language;
import 'package:language_learning/database/database.dart';
import 'package:tuple/tuple.dart';
import 'package:provider/provider.dart';

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

  Future updateCategory(Category category) async {
    await context.read<LanguageDatabase>().updateCategory(category);
    categories[categories.indexWhere((element) => element.id == category.id)] =
        category;
  }

  Future removeCategory(Category category) async {
    await context.read<LanguageDatabase>().removeCategory(category);
    categories.removeWhere((element) => element.id == category.id);
  }

  Future addLanguage(LanguagesCompanion language) async {
    var row = await context.read<LanguageDatabase>().addLanguage(language);
    languages.add(row);
    notifyListeners();
  }

  Future updateLanguage(Language language) async {
    await context.read<LanguageDatabase>().updateLanguage(language);
    languages[languages.indexWhere((element) => element.id == language.id)] =
        language;
  }

  Future removeLanguage(Language language) async {
    await context.read<LanguageDatabase>().removeLanguage(language);
    languages.removeWhere((element) => element.id == language.id);
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

  Future removeWordsOf(Language language) async {
    await context.read<LanguageDatabase>().removeWordsOf(language);
    words.removeWhere((element) => element.language == language.id);
  }

  Future removeVerbsOf(Language language) async {
    await context.read<LanguageDatabase>().removeVerbsOf(language);
    verbs.removeWhere((element) => element.language == language.id);
  }

  Future removePhrasesOf(Language language) async {
    await context.read<LanguageDatabase>().removePhrasesOf(language);
    phrases.removeWhere((element) => element.language == language.id);
  }

  Future removeCategories(Language language) async {
    await context.read<LanguageDatabase>().removeCategories(language);
    categories.removeWhere((element) => element.language == language.id);
  }

  List<Category> getCategories(Language language) {
    return categories
        .where((element) => element.language == language.id)
        .toList();
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

  Future filter(String query, LanguageElement languageElement) async {
    if (query.isNotEmpty) {
      if (languageElement == LanguageElement.word) {
        await filterWords(query);
      } else if (languageElement == LanguageElement.verb) {
        await filterVerbs(query);
      } else {
        await filterPhrases(query);
      }
    } else {
      words = await Provider.of<LanguageDatabase>(context, listen: false)
          .getAllWords();
      verbs = await Provider.of<LanguageDatabase>(context, listen: false)
          .getAllVerbs();
      phrases = await Provider.of<LanguageDatabase>(context, listen: false)
          .getAllPhrases();
    }

    notifyListeners();
  }

  List<Category> filterCategories(String query) {
    return categories.where((element) => element.name.contains(query)).toList();
  }

  Future filterWords(String query) async {
    var allWords = await Provider.of<LanguageDatabase>(context, listen: false)
        .getAllWords();
    words.clear();
    words.addAll(allWords
        .where((element) => element.content.toLowerCase().contains(query))
        .toList());
  }

  Future filterVerbs(String query) async {
    var allVerbs = await Provider.of<LanguageDatabase>(context, listen: false)
        .getAllVerbs();
    verbs.clear();
    verbs.addAll(allVerbs
        .where((element) => element.content.toLowerCase().contains(query))
        .toList());
  }

  Future filterPhrases(String query) async {
    var allPhrases = await Provider.of<LanguageDatabase>(context, listen: false)
        .getAllPhrases();
    phrases.clear();
    phrases.addAll(allPhrases
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
