// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Language extends DataClass implements Insertable<Language> {
  final int id;
  final String name;
  Language({required this.id, required this.name});
  factory Language.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Language(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  LanguagesCompanion toCompanion(bool nullToAbsent) {
    return LanguagesCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory Language.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Language(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Language copyWith({int? id, String? name}) => Language(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Language(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Language && other.id == this.id && other.name == this.name);
}

class LanguagesCompanion extends UpdateCompanion<Language> {
  final Value<int> id;
  final Value<String> name;
  const LanguagesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  LanguagesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<Language> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  LanguagesCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return LanguagesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LanguagesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $LanguagesTable extends Languages
    with TableInfo<$LanguagesTable, Language> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LanguagesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? 'languages';
  @override
  String get actualTableName => 'languages';
  @override
  VerificationContext validateIntegrity(Insertable<Language> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Language map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Language.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $LanguagesTable createAlias(String alias) {
    return $LanguagesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String name;
  final int language;
  Category({required this.id, required this.name, required this.language});
  factory Category.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Category(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      language: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}language'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['language'] = Variable<int>(language);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      language: Value(language),
    );
  }

  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      language: serializer.fromJson<int>(json['language']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'language': serializer.toJson<int>(language),
    };
  }

  Category copyWith({int? id, String? name, int? language}) => Category(
        id: id ?? this.id,
        name: name ?? this.name,
        language: language ?? this.language,
      );
  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('language: $language')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, language);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.language == this.language);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> language;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.language = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int language,
  })  : name = Value(name),
        language = Value(language);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? language,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (language != null) 'language': language,
    });
  }

  CategoriesCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<int>? language}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      language: language ?? this.language,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (language.present) {
      map['language'] = Variable<int>(language.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('language: $language')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _languageMeta = const VerificationMeta('language');
  @override
  late final GeneratedColumn<int?> language = GeneratedColumn<int?>(
      'language', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES languages (id)');
  @override
  List<GeneratedColumn> get $columns => [id, name, language];
  @override
  String get aliasedName => _alias ?? 'categories';
  @override
  String get actualTableName => 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<Category> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language']!, _languageMeta));
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Category.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Word extends DataClass implements Insertable<Word> {
  final int id;
  final int language;
  final String content;
  final String translation;
  final int? category;
  Word(
      {required this.id,
      required this.language,
      required this.content,
      required this.translation,
      this.category});
  factory Word.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Word(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      language: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}language'])!,
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content'])!,
      translation: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}translation'])!,
      category: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['language'] = Variable<int>(language);
    map['content'] = Variable<String>(content);
    map['translation'] = Variable<String>(translation);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<int?>(category);
    }
    return map;
  }

  WordsCompanion toCompanion(bool nullToAbsent) {
    return WordsCompanion(
      id: Value(id),
      language: Value(language),
      content: Value(content),
      translation: Value(translation),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
    );
  }

  factory Word.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Word(
      id: serializer.fromJson<int>(json['id']),
      language: serializer.fromJson<int>(json['language']),
      content: serializer.fromJson<String>(json['content']),
      translation: serializer.fromJson<String>(json['translation']),
      category: serializer.fromJson<int?>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'language': serializer.toJson<int>(language),
      'content': serializer.toJson<String>(content),
      'translation': serializer.toJson<String>(translation),
      'category': serializer.toJson<int?>(category),
    };
  }

  Word copyWith(
          {int? id,
          int? language,
          String? content,
          String? translation,
          int? category}) =>
      Word(
        id: id ?? this.id,
        language: language ?? this.language,
        content: content ?? this.content,
        translation: translation ?? this.translation,
        category: category ?? this.category,
      );
  @override
  String toString() {
    return (StringBuffer('Word(')
          ..write('id: $id, ')
          ..write('language: $language, ')
          ..write('content: $content, ')
          ..write('translation: $translation, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, language, content, translation, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Word &&
          other.id == this.id &&
          other.language == this.language &&
          other.content == this.content &&
          other.translation == this.translation &&
          other.category == this.category);
}

class WordsCompanion extends UpdateCompanion<Word> {
  final Value<int> id;
  final Value<int> language;
  final Value<String> content;
  final Value<String> translation;
  final Value<int?> category;
  const WordsCompanion({
    this.id = const Value.absent(),
    this.language = const Value.absent(),
    this.content = const Value.absent(),
    this.translation = const Value.absent(),
    this.category = const Value.absent(),
  });
  WordsCompanion.insert({
    this.id = const Value.absent(),
    required int language,
    required String content,
    required String translation,
    this.category = const Value.absent(),
  })  : language = Value(language),
        content = Value(content),
        translation = Value(translation);
  static Insertable<Word> custom({
    Expression<int>? id,
    Expression<int>? language,
    Expression<String>? content,
    Expression<String>? translation,
    Expression<int?>? category,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (language != null) 'language': language,
      if (content != null) 'content': content,
      if (translation != null) 'translation': translation,
      if (category != null) 'category': category,
    });
  }

  WordsCompanion copyWith(
      {Value<int>? id,
      Value<int>? language,
      Value<String>? content,
      Value<String>? translation,
      Value<int?>? category}) {
    return WordsCompanion(
      id: id ?? this.id,
      language: language ?? this.language,
      content: content ?? this.content,
      translation: translation ?? this.translation,
      category: category ?? this.category,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (language.present) {
      map['language'] = Variable<int>(language.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (translation.present) {
      map['translation'] = Variable<String>(translation.value);
    }
    if (category.present) {
      map['category'] = Variable<int?>(category.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordsCompanion(')
          ..write('id: $id, ')
          ..write('language: $language, ')
          ..write('content: $content, ')
          ..write('translation: $translation, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }
}

class $WordsTable extends Words with TableInfo<$WordsTable, Word> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _languageMeta = const VerificationMeta('language');
  @override
  late final GeneratedColumn<int?> language = GeneratedColumn<int?>(
      'language', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES languages (id)');
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedColumn<String?> content = GeneratedColumn<String?>(
      'content', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _translationMeta =
      const VerificationMeta('translation');
  @override
  late final GeneratedColumn<String?> translation = GeneratedColumn<String?>(
      'translation', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  @override
  late final GeneratedColumn<int?> category = GeneratedColumn<int?>(
      'category', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES categories (id)');
  @override
  List<GeneratedColumn> get $columns =>
      [id, language, content, translation, category];
  @override
  String get aliasedName => _alias ?? 'words';
  @override
  String get actualTableName => 'words';
  @override
  VerificationContext validateIntegrity(Insertable<Word> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language']!, _languageMeta));
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('translation')) {
      context.handle(
          _translationMeta,
          translation.isAcceptableOrUnknown(
              data['translation']!, _translationMeta));
    } else if (isInserting) {
      context.missing(_translationMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Word map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Word.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $WordsTable createAlias(String alias) {
    return $WordsTable(attachedDatabase, alias);
  }
}

class Verb extends DataClass implements Insertable<Verb> {
  final int id;
  final int language;
  final String content;
  final String translation;
  final String firstPersonSingular;
  final String secondPersonSingular;
  final String thirdPersonSingular;
  final String firstPersonPlural;
  final String secondPersonPlural;
  final String thirdPersonPlural;
  final int? category;
  Verb(
      {required this.id,
      required this.language,
      required this.content,
      required this.translation,
      required this.firstPersonSingular,
      required this.secondPersonSingular,
      required this.thirdPersonSingular,
      required this.firstPersonPlural,
      required this.secondPersonPlural,
      required this.thirdPersonPlural,
      this.category});
  factory Verb.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Verb(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      language: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}language'])!,
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content'])!,
      translation: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}translation'])!,
      firstPersonSingular: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}first_person_singular'])!,
      secondPersonSingular: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}second_person_singular'])!,
      thirdPersonSingular: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}third_person_singular'])!,
      firstPersonPlural: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}first_person_plural'])!,
      secondPersonPlural: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}second_person_plural'])!,
      thirdPersonPlural: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}third_person_plural'])!,
      category: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['language'] = Variable<int>(language);
    map['content'] = Variable<String>(content);
    map['translation'] = Variable<String>(translation);
    map['first_person_singular'] = Variable<String>(firstPersonSingular);
    map['second_person_singular'] = Variable<String>(secondPersonSingular);
    map['third_person_singular'] = Variable<String>(thirdPersonSingular);
    map['first_person_plural'] = Variable<String>(firstPersonPlural);
    map['second_person_plural'] = Variable<String>(secondPersonPlural);
    map['third_person_plural'] = Variable<String>(thirdPersonPlural);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<int?>(category);
    }
    return map;
  }

  VerbsCompanion toCompanion(bool nullToAbsent) {
    return VerbsCompanion(
      id: Value(id),
      language: Value(language),
      content: Value(content),
      translation: Value(translation),
      firstPersonSingular: Value(firstPersonSingular),
      secondPersonSingular: Value(secondPersonSingular),
      thirdPersonSingular: Value(thirdPersonSingular),
      firstPersonPlural: Value(firstPersonPlural),
      secondPersonPlural: Value(secondPersonPlural),
      thirdPersonPlural: Value(thirdPersonPlural),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
    );
  }

  factory Verb.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Verb(
      id: serializer.fromJson<int>(json['id']),
      language: serializer.fromJson<int>(json['language']),
      content: serializer.fromJson<String>(json['content']),
      translation: serializer.fromJson<String>(json['translation']),
      firstPersonSingular:
          serializer.fromJson<String>(json['firstPersonSingular']),
      secondPersonSingular:
          serializer.fromJson<String>(json['secondPersonSingular']),
      thirdPersonSingular:
          serializer.fromJson<String>(json['thirdPersonSingular']),
      firstPersonPlural: serializer.fromJson<String>(json['firstPersonPlural']),
      secondPersonPlural:
          serializer.fromJson<String>(json['secondPersonPlural']),
      thirdPersonPlural: serializer.fromJson<String>(json['thirdPersonPlural']),
      category: serializer.fromJson<int?>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'language': serializer.toJson<int>(language),
      'content': serializer.toJson<String>(content),
      'translation': serializer.toJson<String>(translation),
      'firstPersonSingular': serializer.toJson<String>(firstPersonSingular),
      'secondPersonSingular': serializer.toJson<String>(secondPersonSingular),
      'thirdPersonSingular': serializer.toJson<String>(thirdPersonSingular),
      'firstPersonPlural': serializer.toJson<String>(firstPersonPlural),
      'secondPersonPlural': serializer.toJson<String>(secondPersonPlural),
      'thirdPersonPlural': serializer.toJson<String>(thirdPersonPlural),
      'category': serializer.toJson<int?>(category),
    };
  }

  Verb copyWith(
          {int? id,
          int? language,
          String? content,
          String? translation,
          String? firstPersonSingular,
          String? secondPersonSingular,
          String? thirdPersonSingular,
          String? firstPersonPlural,
          String? secondPersonPlural,
          String? thirdPersonPlural,
          int? category}) =>
      Verb(
        id: id ?? this.id,
        language: language ?? this.language,
        content: content ?? this.content,
        translation: translation ?? this.translation,
        firstPersonSingular: firstPersonSingular ?? this.firstPersonSingular,
        secondPersonSingular: secondPersonSingular ?? this.secondPersonSingular,
        thirdPersonSingular: thirdPersonSingular ?? this.thirdPersonSingular,
        firstPersonPlural: firstPersonPlural ?? this.firstPersonPlural,
        secondPersonPlural: secondPersonPlural ?? this.secondPersonPlural,
        thirdPersonPlural: thirdPersonPlural ?? this.thirdPersonPlural,
        category: category ?? this.category,
      );
  @override
  String toString() {
    return (StringBuffer('Verb(')
          ..write('id: $id, ')
          ..write('language: $language, ')
          ..write('content: $content, ')
          ..write('translation: $translation, ')
          ..write('firstPersonSingular: $firstPersonSingular, ')
          ..write('secondPersonSingular: $secondPersonSingular, ')
          ..write('thirdPersonSingular: $thirdPersonSingular, ')
          ..write('firstPersonPlural: $firstPersonPlural, ')
          ..write('secondPersonPlural: $secondPersonPlural, ')
          ..write('thirdPersonPlural: $thirdPersonPlural, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      language,
      content,
      translation,
      firstPersonSingular,
      secondPersonSingular,
      thirdPersonSingular,
      firstPersonPlural,
      secondPersonPlural,
      thirdPersonPlural,
      category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Verb &&
          other.id == this.id &&
          other.language == this.language &&
          other.content == this.content &&
          other.translation == this.translation &&
          other.firstPersonSingular == this.firstPersonSingular &&
          other.secondPersonSingular == this.secondPersonSingular &&
          other.thirdPersonSingular == this.thirdPersonSingular &&
          other.firstPersonPlural == this.firstPersonPlural &&
          other.secondPersonPlural == this.secondPersonPlural &&
          other.thirdPersonPlural == this.thirdPersonPlural &&
          other.category == this.category);
}

class VerbsCompanion extends UpdateCompanion<Verb> {
  final Value<int> id;
  final Value<int> language;
  final Value<String> content;
  final Value<String> translation;
  final Value<String> firstPersonSingular;
  final Value<String> secondPersonSingular;
  final Value<String> thirdPersonSingular;
  final Value<String> firstPersonPlural;
  final Value<String> secondPersonPlural;
  final Value<String> thirdPersonPlural;
  final Value<int?> category;
  const VerbsCompanion({
    this.id = const Value.absent(),
    this.language = const Value.absent(),
    this.content = const Value.absent(),
    this.translation = const Value.absent(),
    this.firstPersonSingular = const Value.absent(),
    this.secondPersonSingular = const Value.absent(),
    this.thirdPersonSingular = const Value.absent(),
    this.firstPersonPlural = const Value.absent(),
    this.secondPersonPlural = const Value.absent(),
    this.thirdPersonPlural = const Value.absent(),
    this.category = const Value.absent(),
  });
  VerbsCompanion.insert({
    this.id = const Value.absent(),
    required int language,
    required String content,
    required String translation,
    required String firstPersonSingular,
    required String secondPersonSingular,
    required String thirdPersonSingular,
    required String firstPersonPlural,
    required String secondPersonPlural,
    required String thirdPersonPlural,
    this.category = const Value.absent(),
  })  : language = Value(language),
        content = Value(content),
        translation = Value(translation),
        firstPersonSingular = Value(firstPersonSingular),
        secondPersonSingular = Value(secondPersonSingular),
        thirdPersonSingular = Value(thirdPersonSingular),
        firstPersonPlural = Value(firstPersonPlural),
        secondPersonPlural = Value(secondPersonPlural),
        thirdPersonPlural = Value(thirdPersonPlural);
  static Insertable<Verb> custom({
    Expression<int>? id,
    Expression<int>? language,
    Expression<String>? content,
    Expression<String>? translation,
    Expression<String>? firstPersonSingular,
    Expression<String>? secondPersonSingular,
    Expression<String>? thirdPersonSingular,
    Expression<String>? firstPersonPlural,
    Expression<String>? secondPersonPlural,
    Expression<String>? thirdPersonPlural,
    Expression<int?>? category,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (language != null) 'language': language,
      if (content != null) 'content': content,
      if (translation != null) 'translation': translation,
      if (firstPersonSingular != null)
        'first_person_singular': firstPersonSingular,
      if (secondPersonSingular != null)
        'second_person_singular': secondPersonSingular,
      if (thirdPersonSingular != null)
        'third_person_singular': thirdPersonSingular,
      if (firstPersonPlural != null) 'first_person_plural': firstPersonPlural,
      if (secondPersonPlural != null)
        'second_person_plural': secondPersonPlural,
      if (thirdPersonPlural != null) 'third_person_plural': thirdPersonPlural,
      if (category != null) 'category': category,
    });
  }

  VerbsCompanion copyWith(
      {Value<int>? id,
      Value<int>? language,
      Value<String>? content,
      Value<String>? translation,
      Value<String>? firstPersonSingular,
      Value<String>? secondPersonSingular,
      Value<String>? thirdPersonSingular,
      Value<String>? firstPersonPlural,
      Value<String>? secondPersonPlural,
      Value<String>? thirdPersonPlural,
      Value<int?>? category}) {
    return VerbsCompanion(
      id: id ?? this.id,
      language: language ?? this.language,
      content: content ?? this.content,
      translation: translation ?? this.translation,
      firstPersonSingular: firstPersonSingular ?? this.firstPersonSingular,
      secondPersonSingular: secondPersonSingular ?? this.secondPersonSingular,
      thirdPersonSingular: thirdPersonSingular ?? this.thirdPersonSingular,
      firstPersonPlural: firstPersonPlural ?? this.firstPersonPlural,
      secondPersonPlural: secondPersonPlural ?? this.secondPersonPlural,
      thirdPersonPlural: thirdPersonPlural ?? this.thirdPersonPlural,
      category: category ?? this.category,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (language.present) {
      map['language'] = Variable<int>(language.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (translation.present) {
      map['translation'] = Variable<String>(translation.value);
    }
    if (firstPersonSingular.present) {
      map['first_person_singular'] =
          Variable<String>(firstPersonSingular.value);
    }
    if (secondPersonSingular.present) {
      map['second_person_singular'] =
          Variable<String>(secondPersonSingular.value);
    }
    if (thirdPersonSingular.present) {
      map['third_person_singular'] =
          Variable<String>(thirdPersonSingular.value);
    }
    if (firstPersonPlural.present) {
      map['first_person_plural'] = Variable<String>(firstPersonPlural.value);
    }
    if (secondPersonPlural.present) {
      map['second_person_plural'] = Variable<String>(secondPersonPlural.value);
    }
    if (thirdPersonPlural.present) {
      map['third_person_plural'] = Variable<String>(thirdPersonPlural.value);
    }
    if (category.present) {
      map['category'] = Variable<int?>(category.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VerbsCompanion(')
          ..write('id: $id, ')
          ..write('language: $language, ')
          ..write('content: $content, ')
          ..write('translation: $translation, ')
          ..write('firstPersonSingular: $firstPersonSingular, ')
          ..write('secondPersonSingular: $secondPersonSingular, ')
          ..write('thirdPersonSingular: $thirdPersonSingular, ')
          ..write('firstPersonPlural: $firstPersonPlural, ')
          ..write('secondPersonPlural: $secondPersonPlural, ')
          ..write('thirdPersonPlural: $thirdPersonPlural, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }
}

class $VerbsTable extends Verbs with TableInfo<$VerbsTable, Verb> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VerbsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _languageMeta = const VerificationMeta('language');
  @override
  late final GeneratedColumn<int?> language = GeneratedColumn<int?>(
      'language', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES languages (id)');
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedColumn<String?> content = GeneratedColumn<String?>(
      'content', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _translationMeta =
      const VerificationMeta('translation');
  @override
  late final GeneratedColumn<String?> translation = GeneratedColumn<String?>(
      'translation', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _firstPersonSingularMeta =
      const VerificationMeta('firstPersonSingular');
  @override
  late final GeneratedColumn<String?> firstPersonSingular =
      GeneratedColumn<String?>('first_person_singular', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _secondPersonSingularMeta =
      const VerificationMeta('secondPersonSingular');
  @override
  late final GeneratedColumn<String?> secondPersonSingular =
      GeneratedColumn<String?>('second_person_singular', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _thirdPersonSingularMeta =
      const VerificationMeta('thirdPersonSingular');
  @override
  late final GeneratedColumn<String?> thirdPersonSingular =
      GeneratedColumn<String?>('third_person_singular', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _firstPersonPluralMeta =
      const VerificationMeta('firstPersonPlural');
  @override
  late final GeneratedColumn<String?> firstPersonPlural =
      GeneratedColumn<String?>('first_person_plural', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _secondPersonPluralMeta =
      const VerificationMeta('secondPersonPlural');
  @override
  late final GeneratedColumn<String?> secondPersonPlural =
      GeneratedColumn<String?>('second_person_plural', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _thirdPersonPluralMeta =
      const VerificationMeta('thirdPersonPlural');
  @override
  late final GeneratedColumn<String?> thirdPersonPlural =
      GeneratedColumn<String?>('third_person_plural', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  @override
  late final GeneratedColumn<int?> category = GeneratedColumn<int?>(
      'category', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES categories (id)');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        language,
        content,
        translation,
        firstPersonSingular,
        secondPersonSingular,
        thirdPersonSingular,
        firstPersonPlural,
        secondPersonPlural,
        thirdPersonPlural,
        category
      ];
  @override
  String get aliasedName => _alias ?? 'verbs';
  @override
  String get actualTableName => 'verbs';
  @override
  VerificationContext validateIntegrity(Insertable<Verb> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language']!, _languageMeta));
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('translation')) {
      context.handle(
          _translationMeta,
          translation.isAcceptableOrUnknown(
              data['translation']!, _translationMeta));
    } else if (isInserting) {
      context.missing(_translationMeta);
    }
    if (data.containsKey('first_person_singular')) {
      context.handle(
          _firstPersonSingularMeta,
          firstPersonSingular.isAcceptableOrUnknown(
              data['first_person_singular']!, _firstPersonSingularMeta));
    } else if (isInserting) {
      context.missing(_firstPersonSingularMeta);
    }
    if (data.containsKey('second_person_singular')) {
      context.handle(
          _secondPersonSingularMeta,
          secondPersonSingular.isAcceptableOrUnknown(
              data['second_person_singular']!, _secondPersonSingularMeta));
    } else if (isInserting) {
      context.missing(_secondPersonSingularMeta);
    }
    if (data.containsKey('third_person_singular')) {
      context.handle(
          _thirdPersonSingularMeta,
          thirdPersonSingular.isAcceptableOrUnknown(
              data['third_person_singular']!, _thirdPersonSingularMeta));
    } else if (isInserting) {
      context.missing(_thirdPersonSingularMeta);
    }
    if (data.containsKey('first_person_plural')) {
      context.handle(
          _firstPersonPluralMeta,
          firstPersonPlural.isAcceptableOrUnknown(
              data['first_person_plural']!, _firstPersonPluralMeta));
    } else if (isInserting) {
      context.missing(_firstPersonPluralMeta);
    }
    if (data.containsKey('second_person_plural')) {
      context.handle(
          _secondPersonPluralMeta,
          secondPersonPlural.isAcceptableOrUnknown(
              data['second_person_plural']!, _secondPersonPluralMeta));
    } else if (isInserting) {
      context.missing(_secondPersonPluralMeta);
    }
    if (data.containsKey('third_person_plural')) {
      context.handle(
          _thirdPersonPluralMeta,
          thirdPersonPlural.isAcceptableOrUnknown(
              data['third_person_plural']!, _thirdPersonPluralMeta));
    } else if (isInserting) {
      context.missing(_thirdPersonPluralMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Verb map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Verb.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $VerbsTable createAlias(String alias) {
    return $VerbsTable(attachedDatabase, alias);
  }
}

class Phrase extends DataClass implements Insertable<Phrase> {
  final int id;
  final int language;
  final String content;
  final String translation;
  final int? category;
  Phrase(
      {required this.id,
      required this.language,
      required this.content,
      required this.translation,
      this.category});
  factory Phrase.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Phrase(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      language: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}language'])!,
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content'])!,
      translation: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}translation'])!,
      category: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['language'] = Variable<int>(language);
    map['content'] = Variable<String>(content);
    map['translation'] = Variable<String>(translation);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<int?>(category);
    }
    return map;
  }

  PhrasesCompanion toCompanion(bool nullToAbsent) {
    return PhrasesCompanion(
      id: Value(id),
      language: Value(language),
      content: Value(content),
      translation: Value(translation),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
    );
  }

  factory Phrase.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Phrase(
      id: serializer.fromJson<int>(json['id']),
      language: serializer.fromJson<int>(json['language']),
      content: serializer.fromJson<String>(json['content']),
      translation: serializer.fromJson<String>(json['translation']),
      category: serializer.fromJson<int?>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'language': serializer.toJson<int>(language),
      'content': serializer.toJson<String>(content),
      'translation': serializer.toJson<String>(translation),
      'category': serializer.toJson<int?>(category),
    };
  }

  Phrase copyWith(
          {int? id,
          int? language,
          String? content,
          String? translation,
          int? category}) =>
      Phrase(
        id: id ?? this.id,
        language: language ?? this.language,
        content: content ?? this.content,
        translation: translation ?? this.translation,
        category: category ?? this.category,
      );
  @override
  String toString() {
    return (StringBuffer('Phrase(')
          ..write('id: $id, ')
          ..write('language: $language, ')
          ..write('content: $content, ')
          ..write('translation: $translation, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, language, content, translation, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Phrase &&
          other.id == this.id &&
          other.language == this.language &&
          other.content == this.content &&
          other.translation == this.translation &&
          other.category == this.category);
}

class PhrasesCompanion extends UpdateCompanion<Phrase> {
  final Value<int> id;
  final Value<int> language;
  final Value<String> content;
  final Value<String> translation;
  final Value<int?> category;
  const PhrasesCompanion({
    this.id = const Value.absent(),
    this.language = const Value.absent(),
    this.content = const Value.absent(),
    this.translation = const Value.absent(),
    this.category = const Value.absent(),
  });
  PhrasesCompanion.insert({
    this.id = const Value.absent(),
    required int language,
    required String content,
    required String translation,
    this.category = const Value.absent(),
  })  : language = Value(language),
        content = Value(content),
        translation = Value(translation);
  static Insertable<Phrase> custom({
    Expression<int>? id,
    Expression<int>? language,
    Expression<String>? content,
    Expression<String>? translation,
    Expression<int?>? category,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (language != null) 'language': language,
      if (content != null) 'content': content,
      if (translation != null) 'translation': translation,
      if (category != null) 'category': category,
    });
  }

  PhrasesCompanion copyWith(
      {Value<int>? id,
      Value<int>? language,
      Value<String>? content,
      Value<String>? translation,
      Value<int?>? category}) {
    return PhrasesCompanion(
      id: id ?? this.id,
      language: language ?? this.language,
      content: content ?? this.content,
      translation: translation ?? this.translation,
      category: category ?? this.category,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (language.present) {
      map['language'] = Variable<int>(language.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (translation.present) {
      map['translation'] = Variable<String>(translation.value);
    }
    if (category.present) {
      map['category'] = Variable<int?>(category.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhrasesCompanion(')
          ..write('id: $id, ')
          ..write('language: $language, ')
          ..write('content: $content, ')
          ..write('translation: $translation, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }
}

class $PhrasesTable extends Phrases with TableInfo<$PhrasesTable, Phrase> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhrasesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _languageMeta = const VerificationMeta('language');
  @override
  late final GeneratedColumn<int?> language = GeneratedColumn<int?>(
      'language', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES languages (id)');
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedColumn<String?> content = GeneratedColumn<String?>(
      'content', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _translationMeta =
      const VerificationMeta('translation');
  @override
  late final GeneratedColumn<String?> translation = GeneratedColumn<String?>(
      'translation', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  @override
  late final GeneratedColumn<int?> category = GeneratedColumn<int?>(
      'category', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES categories (id)');
  @override
  List<GeneratedColumn> get $columns =>
      [id, language, content, translation, category];
  @override
  String get aliasedName => _alias ?? 'phrases';
  @override
  String get actualTableName => 'phrases';
  @override
  VerificationContext validateIntegrity(Insertable<Phrase> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language']!, _languageMeta));
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('translation')) {
      context.handle(
          _translationMeta,
          translation.isAcceptableOrUnknown(
              data['translation']!, _translationMeta));
    } else if (isInserting) {
      context.missing(_translationMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Phrase map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Phrase.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PhrasesTable createAlias(String alias) {
    return $PhrasesTable(attachedDatabase, alias);
  }
}

abstract class _$LanguageDatabase extends GeneratedDatabase {
  _$LanguageDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $LanguagesTable languages = $LanguagesTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $WordsTable words = $WordsTable(this);
  late final $VerbsTable verbs = $VerbsTable(this);
  late final $PhrasesTable phrases = $PhrasesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [languages, categories, words, verbs, phrases];
}
