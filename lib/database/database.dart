import 'package:language_learning/constants.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';

part 'database.g.dart';

class Phrases extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get language => text()();
  TextColumn get content => text()();
  TextColumn get translation => text()();
  IntColumn get category => integer().nullable().references(Categories, #id)();
}

class Verbs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get language => text()();
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
  TextColumn get language => text()();
  TextColumn get content => text()();
  TextColumn get translation => text()();
  IntColumn get category => integer().nullable().references(Categories, #id)();
}

@DataClassName('Category')
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

@DriftDatabase(tables: [Words, Verbs, Phrases, Categories])
class LanguageDatabase extends _$LanguageDatabase {
  LanguageDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future getElements(Language language, LanguageElement languageElement) {
    if (languageElement == LanguageElement.word) {
      return getWords(language);
    } else if (languageElement == LanguageElement.verb) {
      return getVerbs(language);
    } else {
      return getPhrases(language);
    }
  }

  Future<List<Phrase>> getPhrases(Language language) {
    return (select(phrases)..where((tbl) => tbl.language.equals(language.name)))
        .get();
  }

  Future<List<Verb>> getVerbs(Language language) {
    return (select(verbs)..where((tbl) => tbl.language.equals(language.name)))
        .get();
  }

  Future<List<Word>> getWords(Language language) {
    return (select(words)..where((tbl) => tbl.language.equals(language.name)))
        .get();
  }

  Future<int> addWord(WordsCompanion word) {
    return into(words).insert(word);
  }

  Future updateWord(Word word) {
    return update(words).replace(word);
  }

  Future removeWord(String wordContent) {
    return (delete(words)..where((t) => t.content.equals(wordContent))).go();
  }

  Future removeAllWords() {
    return delete(words).go();
  }

  Future<int> addVerb(VerbsCompanion verb) {
    return into(verbs).insert(verb);
  }

  Future updateVerb(Verb verb) {
    return update(verbs).replace(verb);
  }

  Future removeVerb(String verbContent) {
    return (delete(verbs)..where((t) => t.content.equals(verbContent))).go();
  }

  Future removeAllVerbs() {
    return delete(verbs).go();
  }

  Future<int> addPhrase(PhrasesCompanion phrase) {
    return into(phrases).insert(phrase);
  }

  Future updatePhrase(Phrase phrase) {
    return update(phrases).replace(phrase);
  }

  Future removePhrase(String phraseContent) {
    return (delete(phrases)..where((t) => t.content.equals(phraseContent)))
        .go();
  }

  Future removeAllPhrases() {
    return delete(phrases).go();
  }
}
