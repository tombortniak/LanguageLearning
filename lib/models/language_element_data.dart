import 'package:flutter/material.dart';
import 'package:language_learning/constants.dart';
import 'package:language_learning/database/database.dart';
import 'package:tuple/tuple.dart';
import 'package:provider/provider.dart';

class LanguageElementData extends ChangeNotifier {
  Tuple3<List<Word>, List<Verb>, List<Phrase>> languageElements =
      Tuple3<List<Word>, List<Verb>, List<Phrase>>([], [], []);
  Tuple3<List<Word>, List<Verb>, List<Phrase>> viewLanguageElements =
      Tuple3<List<Word>, List<Verb>, List<Phrase>>([], [], []);
  List<Category> categories = [];

  BuildContext context;

  LanguageElementData({required this.context});

  void initalize(
      Tuple4<List<Word>, List<Verb>, List<Phrase>, List<Category>> elements) {
    languageElements = Tuple3(elements.item1, elements.item2, elements.item3);
    viewLanguageElements = Tuple3(List.from(languageElements.item1),
        List.from(languageElements.item2), List.from(languageElements.item3));
    categories = elements.item4;
  }

  Future addCategory(CategoriesCompanion category) async {
    var row = await Provider.of<LanguageDatabase>(context, listen: false)
        .addCategory(category);
    categories.add(row);
    notifyListeners();
  }

  Future addElement(dynamic element, LanguageElement languageElement) async {
    if (languageElement == LanguageElement.word) {
      var row = await Provider.of<LanguageDatabase>(context, listen: false)
          .addWord(element);
      languageElements.item1.add(row);
      viewLanguageElements.item1.add(row);
    } else if (languageElement == LanguageElement.verb) {
      var row = await Provider.of<LanguageDatabase>(context, listen: false)
          .addVerb(element);
      languageElements.item2.add(row);
      viewLanguageElements.item2.add(row);
    } else {
      final row = await Provider.of<LanguageDatabase>(context, listen: false)
          .addPhrase(element as PhrasesCompanion);
      languageElements.item3.add(row);
      viewLanguageElements.item3.add(row);
    }
    notifyListeners();
  }

  Future updateElement(dynamic element, LanguageElement languageElement) async {
    if (languageElement == LanguageElement.word) {
      await Provider.of<LanguageDatabase>(context, listen: false)
          .updateWord(element);
      languageElements.item1[languageElements.item1
          .indexWhere((e) => e.id == (element as Word).id)] = element as Word;
      viewLanguageElements.item1[viewLanguageElements.item1
          .indexWhere((e) => e.id == element.id)] = element;
    } else if (languageElement == LanguageElement.verb) {
      await Provider.of<LanguageDatabase>(context, listen: false)
          .updateVerb(element);
      languageElements.item2[languageElements.item2
          .indexWhere((e) => e.id == (element as Verb).id)] = element as Verb;
      viewLanguageElements.item2[viewLanguageElements.item2
          .indexWhere((e) => e.id == element.id)] = element;
    } else {
      await Provider.of<LanguageDatabase>(context, listen: false)
          .updatePhrase(element);
      languageElements.item3[languageElements.item3
              .indexWhere((e) => e.id == (element as Phrase).id)] =
          element as Phrase;
      viewLanguageElements.item3[viewLanguageElements.item3
          .indexWhere((e) => e.id == element.id)] = element;
    }
    notifyListeners();
  }

  Future removeElement(dynamic element, LanguageElement languageElement) async {
    if (languageElement == LanguageElement.word) {
      await Provider.of<LanguageDatabase>(context, listen: false)
          .removeWord(element as Word);
      languageElements.item1.removeWhere((e) => e.id == element.id);
      viewLanguageElements.item1.removeWhere((e) => e.id == element.id);
    } else if (languageElement == LanguageElement.verb) {
      await Provider.of<LanguageDatabase>(context, listen: false)
          .removeVerb(element as Verb);
      languageElements.item2.removeWhere((e) => e.id == element.id);
      viewLanguageElements.item2.removeWhere((e) => e.id == element.id);
    } else {
      await Provider.of<LanguageDatabase>(context, listen: false)
          .removePhrase(element as Phrase);
      languageElements.item3.removeWhere((e) => e.id == element.id);
      viewLanguageElements.item3.removeWhere((e) => e.id == element.id);
    }
    notifyListeners();
  }

  List<Category> getCategories() {
    return categories;
  }

  List<dynamic> getElements(LanguageElement languageElement) {
    if (languageElement == LanguageElement.word) {
      return languageElements.item1;
    } else if (languageElement == LanguageElement.verb) {
      return languageElements.item2;
    } else {
      return languageElements.item3;
    }
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
    viewLanguageElements.item1.clear();
    viewLanguageElements.item1.addAll(languageElements.item1
        .where((element) => element.content.toLowerCase().contains(query))
        .toList());
  }

  void filterVerbs(String query) {
    viewLanguageElements.item2.clear();
    viewLanguageElements.item2.addAll(languageElements.item2
        .where((element) => element.content.toLowerCase().contains(query))
        .toList());
  }

  void filterPhrases(String query) {
    viewLanguageElements.item3.clear();
    viewLanguageElements.item3.addAll(languageElements.item3
        .where((element) => element.content.toLowerCase().contains(query))
        .toList());
  }

  bool contains(String query, LanguageElement languageElement) {
    if (languageElement == LanguageElement.word) {
      return languageElements.item1.any((e) => e.content == query);
    } else if (languageElement == LanguageElement.verb) {
      return languageElements.item2.any((e) => e.content == query);
    } else {
      return languageElements.item3.any((e) => e.content == query);
    }
  }
}
