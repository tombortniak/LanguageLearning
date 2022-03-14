// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Word extends DataClass implements Insertable<Word> {
  final int id;
  final String language;
  final String content;
  final String translation;
  Word(
      {required this.id,
      required this.language,
      required this.content,
      required this.translation});
  factory Word.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Word(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      language: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}language'])!,
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content'])!,
      translation: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}translation'])!,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['language'] = Variable<String>(language);
    map['content'] = Variable<String>(content);
    map['translation'] = Variable<String>(translation);
    return map;
  }

  WordsCompanion toCompanion(bool nullToAbsent) {
    return WordsCompanion(
      id: Value(id),
      language: Value(language),
      content: Value(content),
      translation: Value(translation),
    );
  }

  factory Word.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Word(
      id: serializer.fromJson<int>(json['id']),
      language: serializer.fromJson<String>(json['language']),
      content: serializer.fromJson<String>(json['content']),
      translation: serializer.fromJson<String>(json['translation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'language': serializer.toJson<String>(language),
      'content': serializer.toJson<String>(content),
      'translation': serializer.toJson<String>(translation),
    };
  }

  Word copyWith(
          {int? id, String? language, String? content, String? translation}) =>
      Word(
        id: id ?? this.id,
        language: language ?? this.language,
        content: content ?? this.content,
        translation: translation ?? this.translation,
      );
  @override
  String toString() {
    return (StringBuffer('Word(')
          ..write('id: $id, ')
          ..write('language: $language, ')
          ..write('content: $content, ')
          ..write('translation: $translation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, language, content, translation);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Word &&
          other.id == this.id &&
          other.language == this.language &&
          other.content == this.content &&
          other.translation == this.translation);
}

class WordsCompanion extends UpdateCompanion<Word> {
  final Value<int> id;
  final Value<String> language;
  final Value<String> content;
  final Value<String> translation;
  const WordsCompanion({
    this.id = const Value.absent(),
    this.language = const Value.absent(),
    this.content = const Value.absent(),
    this.translation = const Value.absent(),
  });
  WordsCompanion.insert({
    this.id = const Value.absent(),
    required String language,
    required String content,
    required String translation,
  })  : language = Value(language),
        content = Value(content),
        translation = Value(translation);
  static Insertable<Word> custom({
    Expression<int>? id,
    Expression<String>? language,
    Expression<String>? content,
    Expression<String>? translation,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (language != null) 'language': language,
      if (content != null) 'content': content,
      if (translation != null) 'translation': translation,
    });
  }

  WordsCompanion copyWith(
      {Value<int>? id,
      Value<String>? language,
      Value<String>? content,
      Value<String>? translation}) {
    return WordsCompanion(
      id: id ?? this.id,
      language: language ?? this.language,
      content: content ?? this.content,
      translation: translation ?? this.translation,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (translation.present) {
      map['translation'] = Variable<String>(translation.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordsCompanion(')
          ..write('id: $id, ')
          ..write('language: $language, ')
          ..write('content: $content, ')
          ..write('translation: $translation')
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
  late final GeneratedColumn<String?> language = GeneratedColumn<String?>(
      'language', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
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
  @override
  List<GeneratedColumn> get $columns => [id, language, content, translation];
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
  final String language;
  final String content;
  final String translation;
  final String firstPersonSingular;
  final String secondPersonSingular;
  final String thirdPersonSingular;
  final String firstPersonPlural;
  final String secondPersonPlural;
  final String thirdPersonPlural;
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
      required this.thirdPersonPlural});
  factory Verb.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Verb(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      language: const StringType()
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
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['language'] = Variable<String>(language);
    map['content'] = Variable<String>(content);
    map['translation'] = Variable<String>(translation);
    map['first_person_singular'] = Variable<String>(firstPersonSingular);
    map['second_person_singular'] = Variable<String>(secondPersonSingular);
    map['third_person_singular'] = Variable<String>(thirdPersonSingular);
    map['first_person_plural'] = Variable<String>(firstPersonPlural);
    map['second_person_plural'] = Variable<String>(secondPersonPlural);
    map['third_person_plural'] = Variable<String>(thirdPersonPlural);
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
    );
  }

  factory Verb.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Verb(
      id: serializer.fromJson<int>(json['id']),
      language: serializer.fromJson<String>(json['language']),
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
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'language': serializer.toJson<String>(language),
      'content': serializer.toJson<String>(content),
      'translation': serializer.toJson<String>(translation),
      'firstPersonSingular': serializer.toJson<String>(firstPersonSingular),
      'secondPersonSingular': serializer.toJson<String>(secondPersonSingular),
      'thirdPersonSingular': serializer.toJson<String>(thirdPersonSingular),
      'firstPersonPlural': serializer.toJson<String>(firstPersonPlural),
      'secondPersonPlural': serializer.toJson<String>(secondPersonPlural),
      'thirdPersonPlural': serializer.toJson<String>(thirdPersonPlural),
    };
  }

  Verb copyWith(
          {int? id,
          String? language,
          String? content,
          String? translation,
          String? firstPersonSingular,
          String? secondPersonSingular,
          String? thirdPersonSingular,
          String? firstPersonPlural,
          String? secondPersonPlural,
          String? thirdPersonPlural}) =>
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
          ..write('thirdPersonPlural: $thirdPersonPlural')
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
      thirdPersonPlural);
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
          other.thirdPersonPlural == this.thirdPersonPlural);
}

class VerbsCompanion extends UpdateCompanion<Verb> {
  final Value<int> id;
  final Value<String> language;
  final Value<String> content;
  final Value<String> translation;
  final Value<String> firstPersonSingular;
  final Value<String> secondPersonSingular;
  final Value<String> thirdPersonSingular;
  final Value<String> firstPersonPlural;
  final Value<String> secondPersonPlural;
  final Value<String> thirdPersonPlural;
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
  });
  VerbsCompanion.insert({
    this.id = const Value.absent(),
    required String language,
    required String content,
    required String translation,
    required String firstPersonSingular,
    required String secondPersonSingular,
    required String thirdPersonSingular,
    required String firstPersonPlural,
    required String secondPersonPlural,
    required String thirdPersonPlural,
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
    Expression<String>? language,
    Expression<String>? content,
    Expression<String>? translation,
    Expression<String>? firstPersonSingular,
    Expression<String>? secondPersonSingular,
    Expression<String>? thirdPersonSingular,
    Expression<String>? firstPersonPlural,
    Expression<String>? secondPersonPlural,
    Expression<String>? thirdPersonPlural,
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
    });
  }

  VerbsCompanion copyWith(
      {Value<int>? id,
      Value<String>? language,
      Value<String>? content,
      Value<String>? translation,
      Value<String>? firstPersonSingular,
      Value<String>? secondPersonSingular,
      Value<String>? thirdPersonSingular,
      Value<String>? firstPersonPlural,
      Value<String>? secondPersonPlural,
      Value<String>? thirdPersonPlural}) {
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
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
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
          ..write('thirdPersonPlural: $thirdPersonPlural')
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
  late final GeneratedColumn<String?> language = GeneratedColumn<String?>(
      'language', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
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
        thirdPersonPlural
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
  final String language;
  final String content;
  final String translation;
  Phrase(
      {required this.id,
      required this.language,
      required this.content,
      required this.translation});
  factory Phrase.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Phrase(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      language: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}language'])!,
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content'])!,
      translation: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}translation'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['language'] = Variable<String>(language);
    map['content'] = Variable<String>(content);
    map['translation'] = Variable<String>(translation);
    return map;
  }

  PhrasesCompanion toCompanion(bool nullToAbsent) {
    return PhrasesCompanion(
      id: Value(id),
      language: Value(language),
      content: Value(content),
      translation: Value(translation),
    );
  }

  factory Phrase.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Phrase(
      id: serializer.fromJson<int>(json['id']),
      language: serializer.fromJson<String>(json['language']),
      content: serializer.fromJson<String>(json['content']),
      translation: serializer.fromJson<String>(json['translation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'language': serializer.toJson<String>(language),
      'content': serializer.toJson<String>(content),
      'translation': serializer.toJson<String>(translation),
    };
  }

  Phrase copyWith(
          {int? id, String? language, String? content, String? translation}) =>
      Phrase(
        id: id ?? this.id,
        language: language ?? this.language,
        content: content ?? this.content,
        translation: translation ?? this.translation,
      );
  @override
  String toString() {
    return (StringBuffer('Phrase(')
          ..write('id: $id, ')
          ..write('language: $language, ')
          ..write('content: $content, ')
          ..write('translation: $translation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, language, content, translation);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Phrase &&
          other.id == this.id &&
          other.language == this.language &&
          other.content == this.content &&
          other.translation == this.translation);
}

class PhrasesCompanion extends UpdateCompanion<Phrase> {
  final Value<int> id;
  final Value<String> language;
  final Value<String> content;
  final Value<String> translation;
  const PhrasesCompanion({
    this.id = const Value.absent(),
    this.language = const Value.absent(),
    this.content = const Value.absent(),
    this.translation = const Value.absent(),
  });
  PhrasesCompanion.insert({
    this.id = const Value.absent(),
    required String language,
    required String content,
    required String translation,
  })  : language = Value(language),
        content = Value(content),
        translation = Value(translation);
  static Insertable<Phrase> custom({
    Expression<int>? id,
    Expression<String>? language,
    Expression<String>? content,
    Expression<String>? translation,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (language != null) 'language': language,
      if (content != null) 'content': content,
      if (translation != null) 'translation': translation,
    });
  }

  PhrasesCompanion copyWith(
      {Value<int>? id,
      Value<String>? language,
      Value<String>? content,
      Value<String>? translation}) {
    return PhrasesCompanion(
      id: id ?? this.id,
      language: language ?? this.language,
      content: content ?? this.content,
      translation: translation ?? this.translation,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (translation.present) {
      map['translation'] = Variable<String>(translation.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhrasesCompanion(')
          ..write('id: $id, ')
          ..write('language: $language, ')
          ..write('content: $content, ')
          ..write('translation: $translation')
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
  late final GeneratedColumn<String?> language = GeneratedColumn<String?>(
      'language', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
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
  @override
  List<GeneratedColumn> get $columns => [id, language, content, translation];
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
  late final $WordsTable words = $WordsTable(this);
  late final $VerbsTable verbs = $VerbsTable(this);
  late final $PhrasesTable phrases = $PhrasesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [words, verbs, phrases];
}
