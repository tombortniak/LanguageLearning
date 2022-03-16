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
  TextColumn get category => text().withDefault(const Constant('inne'))();
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
  TextColumn get category => text().withDefault(const Constant('inne'))();
}

class Words extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get language => text()();
  TextColumn get content => text()();
  TextColumn get translation => text()();
  TextColumn get category => text().withDefault(const Constant('inne'))();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Words, Verbs, Phrases])
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

  Future<List<Word>> getWords(Language language) {
    return (select(words)..where((tbl) => tbl.language.equals(language.name)))
        .get();
  }

  Future<List<Word>> getAllWords() {
    return (select(words)).get();
  }

  Future<List<Verb>> getVerbs(Language language) {
    return (select(verbs)..where((tbl) => tbl.language.equals(language.name)))
        .get();
  }

  Future<List<Verb>> getAllVerbs() {
    return (select(verbs)).get();
  }

  Future<List<Phrase>> getPhrases(Language language) {
    return (select(phrases)..where((tbl) => tbl.language.equals(language.name)))
        .get();
  }

  Future<List<Phrase>> getAllPhrases() {
    return (select(phrases)).get();
  }

  Future<Word> addWord(WordsCompanion word) {
    final row = into(words).insertReturning(
      WordsCompanion.insert(
          language: word.language.value,
          content: word.content.value,
          translation: word.translation.value),
    );
    return row;
  }

  Future updateWord(Word word) {
    return update(words).replace(word);
  }

  Future removeWord(Word word) {
    return (delete(words)..where((t) => t.id.equals(word.id))).go();
  }

  Future removeAllWords() {
    return delete(words).go();
  }

  Future<Verb> addVerb(VerbsCompanion verb) {
    final row = into(verbs).insertReturning(
      VerbsCompanion.insert(
          language: verb.language.value,
          content: verb.content.value,
          translation: verb.translation.value,
          firstPersonSingular: verb.firstPersonSingular.value,
          secondPersonSingular: verb.secondPersonSingular.value,
          thirdPersonSingular: verb.thirdPersonSingular.value,
          firstPersonPlural: verb.firstPersonPlural.value,
          secondPersonPlural: verb.secondPersonPlural.value,
          thirdPersonPlural: verb.thirdPersonPlural.value),
    );
    return row;
  }

  Future updateVerb(Verb verb) {
    return update(verbs).replace(verb);
  }

  Future removeVerb(Verb verb) {
    return (delete(verbs)..where((t) => t.id.equals(verb.id))).go();
  }

  Future removeAllVerbs() {
    return delete(verbs).go();
  }

  Future<Phrase> addPhrase(PhrasesCompanion phrase) {
    final row = into(phrases).insertReturning(
      PhrasesCompanion.insert(
          language: phrase.language.value,
          content: phrase.content.value,
          translation: phrase.translation.value),
    );

    return row;
  }

  Future updatePhrase(Phrase phrase) {
    return update(phrases).replace(phrase);
  }

  Future removePhrase(Phrase phrase) {
    return (delete(phrases)..where((t) => t.id.equals(phrase.id))).go();
  }

  Future removeAllPhrases() {
    return delete(phrases).go();
  }
}
