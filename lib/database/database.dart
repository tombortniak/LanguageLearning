import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'dart:io';

part 'database.g.dart';

class Phrases extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get language => text()();
  TextColumn get content => text()();
  TextColumn get polish_translation => text()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Phrases])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Phrase>> get allPhrases => select(phrases).get();

  Future<int> add(PhrasesCompanion phrase) {
    return into(phrases).insert(phrase);
  }

  Future remove(int id) {
    return (delete(phrases)..where((t) => t.id.equals(id))).go();
  }

  Future removeAll() {
    return delete(phrases).go();
  }
}
