// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Phrase extends DataClass implements Insertable<Phrase> {
  final int id;
  final String language;
  final String content;
  final String polish_translation;
  Phrase(
      {required this.id,
      required this.language,
      required this.content,
      required this.polish_translation});
  factory Phrase.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Phrase(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      language: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}language'])!,
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content'])!,
      polish_translation: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}polish_translation'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['language'] = Variable<String>(language);
    map['content'] = Variable<String>(content);
    map['polish_translation'] = Variable<String>(polish_translation);
    return map;
  }

  PhrasesCompanion toCompanion(bool nullToAbsent) {
    return PhrasesCompanion(
      id: Value(id),
      language: Value(language),
      content: Value(content),
      polish_translation: Value(polish_translation),
    );
  }

  factory Phrase.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Phrase(
      id: serializer.fromJson<int>(json['id']),
      language: serializer.fromJson<String>(json['language']),
      content: serializer.fromJson<String>(json['content']),
      polish_translation:
          serializer.fromJson<String>(json['polish_translation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'language': serializer.toJson<String>(language),
      'content': serializer.toJson<String>(content),
      'polish_translation': serializer.toJson<String>(polish_translation),
    };
  }

  Phrase copyWith(
          {int? id,
          String? language,
          String? content,
          String? polish_translation}) =>
      Phrase(
        id: id ?? this.id,
        language: language ?? this.language,
        content: content ?? this.content,
        polish_translation: polish_translation ?? this.polish_translation,
      );
  @override
  String toString() {
    return (StringBuffer('Phrase(')
          ..write('id: $id, ')
          ..write('language: $language, ')
          ..write('content: $content, ')
          ..write('polish_translation: $polish_translation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, language, content, polish_translation);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Phrase &&
          other.id == this.id &&
          other.language == this.language &&
          other.content == this.content &&
          other.polish_translation == this.polish_translation);
}

class PhrasesCompanion extends UpdateCompanion<Phrase> {
  final Value<int> id;
  final Value<String> language;
  final Value<String> content;
  final Value<String> polish_translation;
  const PhrasesCompanion({
    this.id = const Value.absent(),
    this.language = const Value.absent(),
    this.content = const Value.absent(),
    this.polish_translation = const Value.absent(),
  });
  PhrasesCompanion.insert({
    this.id = const Value.absent(),
    required String language,
    required String content,
    required String polish_translation,
  })  : language = Value(language),
        content = Value(content),
        polish_translation = Value(polish_translation);
  static Insertable<Phrase> custom({
    Expression<int>? id,
    Expression<String>? language,
    Expression<String>? content,
    Expression<String>? polish_translation,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (language != null) 'language': language,
      if (content != null) 'content': content,
      if (polish_translation != null) 'polish_translation': polish_translation,
    });
  }

  PhrasesCompanion copyWith(
      {Value<int>? id,
      Value<String>? language,
      Value<String>? content,
      Value<String>? polish_translation}) {
    return PhrasesCompanion(
      id: id ?? this.id,
      language: language ?? this.language,
      content: content ?? this.content,
      polish_translation: polish_translation ?? this.polish_translation,
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
    if (polish_translation.present) {
      map['polish_translation'] = Variable<String>(polish_translation.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhrasesCompanion(')
          ..write('id: $id, ')
          ..write('language: $language, ')
          ..write('content: $content, ')
          ..write('polish_translation: $polish_translation')
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
  final VerificationMeta _polish_translationMeta =
      const VerificationMeta('polish_translation');
  @override
  late final GeneratedColumn<String?> polish_translation =
      GeneratedColumn<String?>('polish_translation', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, language, content, polish_translation];
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
    if (data.containsKey('polish_translation')) {
      context.handle(
          _polish_translationMeta,
          polish_translation.isAcceptableOrUnknown(
              data['polish_translation']!, _polish_translationMeta));
    } else if (isInserting) {
      context.missing(_polish_translationMeta);
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

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $PhrasesTable phrases = $PhrasesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [phrases];
}
