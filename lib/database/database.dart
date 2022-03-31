import 'package:language_learning/constants.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';

part 'database.g.dart';

class Phrases extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get language => integer().references(Languages, #id)();
  TextColumn get content => text()();
  TextColumn get translation => text()();
  IntColumn get category => integer().nullable().references(Categories, #id)();
}

class Verbs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get language => integer().references(Languages, #id)();
  TextColumn get content => text()();
  TextColumn get translation => text()();
  TextColumn get firstPersonSingular => text()();
  TextColumn get secondPersonSingular => text()();
  TextColumn get thirdPersonSingular => text()();
  TextColumn get firstPersonPlural => text()();
  TextColumn get secondPersonPlural => text()();
  TextColumn get thirdPersonPlural => text()();
  IntColumn get category => integer().nullable().references(Categories, #id)();
}

class Words extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get language => integer().references(Languages, #id)();
  TextColumn get content => text()();
  TextColumn get translation => text()();
  IntColumn get category => integer().nullable().references(Categories, #id)();
}

@DataClassName("Language")
class Languages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

@DataClassName("Category")
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Words, Verbs, Phrases, Categories, Languages])
class LanguageDatabase extends _$LanguageDatabase {
  LanguageDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(onCreate: (m) async {
      await m.createAll();
      await into(categories).insert(CategoriesCompanion.insert(
        name: 'inne',
      ));
    });
  }

  Future<List<Language>> getLanguages() {
    return (select(languages)).get();
  }

  Future getAllCategories() {
    return (select(categories)).get();
  }

  Future getElements(Language language, LanguageElement languageElement) {
    if (languageElement == LanguageElement.word) {
      return getWords(language);
    } else if (languageElement == LanguageElement.verb) {
      return getVerbs(language);
    } else {
      return getPhrases(language);
    }
  }

  Future<List<Word>> getWords(Language language) {
    return (select(words)..where((tbl) => tbl.language.equals(language.id)))
        .get();
  }

  Future<List<Word>> getAllWords() {
    return (select(words)).get();
  }

  Future<List<Verb>> getVerbs(Language language) {
    return (select(verbs)..where((tbl) => tbl.language.equals(language.id)))
        .get();
  }

  Future<List<Verb>> getAllVerbs() {
    return (select(verbs)).get();
  }

  Future<List<Phrase>> getPhrases(Language language) {
    return (select(phrases)..where((tbl) => tbl.language.equals(language.id)))
        .get();
  }

  Future<List<Phrase>> getAllPhrases() {
    return (select(phrases)).get();
  }

  Future removeLanguage(Language language) {
    return (delete(languages)..where((tbl) => tbl.id.equals(language.id))).go();
  }

  Future updateLanguage(Language language) {
    return update(languages).replace(language);
  }

  Future addLanguage(LanguagesCompanion language) {
    return into(languages).insertReturning(language);
  }

  Future addCategory(CategoriesCompanion category) {
    final row = into(categories).insertReturning(category);
    return row;
  }

  Future<Word> addWord(WordsCompanion word) {
    final row = into(words).insertReturning(word);
    return row;
  }

  Future updateWord(Word word) {
    return update(words).replace(word);
  }

  Future removeWord(Word word) {
    return (delete(words)..where((tbl) => tbl.id.equals(word.id))).go();
  }

  Future removeWordsOf(Language language) {
    return (delete(words)..where((tbl) => tbl.language.equals(language.id)))
        .go();
  }

  Future removeAllWords() {
    return delete(words).go();
  }

  Future<Verb> addVerb(VerbsCompanion verb) {
    final row = into(verbs).insertReturning(verb);
    return row;
  }

  Future updateVerb(Verb verb) {
    return update(verbs).replace(verb);
  }

  Future removeVerb(Verb verb) {
    return (delete(verbs)..where((tbl) => tbl.id.equals(verb.id))).go();
  }

  Future removeVerbsOf(Language language) {
    return (delete(verbs)..where((tbl) => tbl.language.equals(language.id)))
        .go();
  }

  Future removeAllVerbs() {
    return delete(verbs).go();
  }

  Future<Phrase> addPhrase(PhrasesCompanion phrase) {
    final row = into(phrases).insertReturning(phrase);

    return row;
  }

  Future updatePhrase(Phrase phrase) {
    return update(phrases).replace(phrase);
  }

  Future removePhrase(Phrase phrase) {
    return (delete(phrases)..where((tbl) => tbl.id.equals(phrase.id))).go();
  }

  Future removePhrasesOf(Language language) {
    return (delete(phrases)..where((tbl) => tbl.language.equals(language.id)))
        .go();
  }

  Future removeAllPhrases() {
    return delete(phrases).go();
  }
}
