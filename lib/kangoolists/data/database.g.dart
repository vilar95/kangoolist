// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $KangooListTableTable extends KangooListTable
    with TableInfo<$KangooListTableTable, KangooListTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KangooListTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 4, maxTextLength: 30),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _obsMeta = const VerificationMeta('obs');
  @override
  late final GeneratedColumn<String> obs = GeneratedColumn<String>(
      'obs', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateCreateMeta =
      const VerificationMeta('dateCreate');
  @override
  late final GeneratedColumn<DateTime> dateCreate = GeneratedColumn<DateTime>(
      'dateCreate', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _dateUpdateMeta =
      const VerificationMeta('dateUpdate');
  @override
  late final GeneratedColumn<DateTime> dateUpdate = GeneratedColumn<DateTime>(
      'dateUpdate', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, obs, dateCreate, dateUpdate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kangoo_list_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<KangooListTableData> instance,
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
    if (data.containsKey('obs')) {
      context.handle(
          _obsMeta, obs.isAcceptableOrUnknown(data['obs']!, _obsMeta));
    } else if (isInserting) {
      context.missing(_obsMeta);
    }
    if (data.containsKey('dateCreate')) {
      context.handle(
          _dateCreateMeta,
          dateCreate.isAcceptableOrUnknown(
              data['dateCreate']!, _dateCreateMeta));
    } else if (isInserting) {
      context.missing(_dateCreateMeta);
    }
    if (data.containsKey('dateUpdate')) {
      context.handle(
          _dateUpdateMeta,
          dateUpdate.isAcceptableOrUnknown(
              data['dateUpdate']!, _dateUpdateMeta));
    } else if (isInserting) {
      context.missing(_dateUpdateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KangooListTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KangooListTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      obs: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}obs'])!,
      dateCreate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}dateCreate'])!,
      dateUpdate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}dateUpdate'])!,
    );
  }

  @override
  $KangooListTableTable createAlias(String alias) {
    return $KangooListTableTable(attachedDatabase, alias);
  }
}

class KangooListTableData extends DataClass
    implements Insertable<KangooListTableData> {
  final int id;
  final String name;
  final String obs;
  final DateTime dateCreate;
  final DateTime dateUpdate;
  const KangooListTableData(
      {required this.id,
      required this.name,
      required this.obs,
      required this.dateCreate,
      required this.dateUpdate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['obs'] = Variable<String>(obs);
    map['dateCreate'] = Variable<DateTime>(dateCreate);
    map['dateUpdate'] = Variable<DateTime>(dateUpdate);
    return map;
  }

  KangooListTableCompanion toCompanion(bool nullToAbsent) {
    return KangooListTableCompanion(
      id: Value(id),
      name: Value(name),
      obs: Value(obs),
      dateCreate: Value(dateCreate),
      dateUpdate: Value(dateUpdate),
    );
  }

  factory KangooListTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KangooListTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      obs: serializer.fromJson<String>(json['obs']),
      dateCreate: serializer.fromJson<DateTime>(json['dateCreate']),
      dateUpdate: serializer.fromJson<DateTime>(json['dateUpdate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'obs': serializer.toJson<String>(obs),
      'dateCreate': serializer.toJson<DateTime>(dateCreate),
      'dateUpdate': serializer.toJson<DateTime>(dateUpdate),
    };
  }

  KangooListTableData copyWith(
          {int? id,
          String? name,
          String? obs,
          DateTime? dateCreate,
          DateTime? dateUpdate}) =>
      KangooListTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        obs: obs ?? this.obs,
        dateCreate: dateCreate ?? this.dateCreate,
        dateUpdate: dateUpdate ?? this.dateUpdate,
      );
  @override
  String toString() {
    return (StringBuffer('KangooListTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('obs: $obs, ')
          ..write('dateCreate: $dateCreate, ')
          ..write('dateUpdate: $dateUpdate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, obs, dateCreate, dateUpdate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KangooListTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.obs == this.obs &&
          other.dateCreate == this.dateCreate &&
          other.dateUpdate == this.dateUpdate);
}

class KangooListTableCompanion extends UpdateCompanion<KangooListTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> obs;
  final Value<DateTime> dateCreate;
  final Value<DateTime> dateUpdate;
  const KangooListTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.obs = const Value.absent(),
    this.dateCreate = const Value.absent(),
    this.dateUpdate = const Value.absent(),
  });
  KangooListTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String obs,
    required DateTime dateCreate,
    required DateTime dateUpdate,
  })  : name = Value(name),
        obs = Value(obs),
        dateCreate = Value(dateCreate),
        dateUpdate = Value(dateUpdate);
  static Insertable<KangooListTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? obs,
    Expression<DateTime>? dateCreate,
    Expression<DateTime>? dateUpdate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (obs != null) 'obs': obs,
      if (dateCreate != null) 'dateCreate': dateCreate,
      if (dateUpdate != null) 'dateUpdate': dateUpdate,
    });
  }

  KangooListTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? obs,
      Value<DateTime>? dateCreate,
      Value<DateTime>? dateUpdate}) {
    return KangooListTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      obs: obs ?? this.obs,
      dateCreate: dateCreate ?? this.dateCreate,
      dateUpdate: dateUpdate ?? this.dateUpdate,
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
    if (obs.present) {
      map['obs'] = Variable<String>(obs.value);
    }
    if (dateCreate.present) {
      map['dateCreate'] = Variable<DateTime>(dateCreate.value);
    }
    if (dateUpdate.present) {
      map['dateUpdate'] = Variable<DateTime>(dateUpdate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KangooListTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('obs: $obs, ')
          ..write('dateCreate: $dateCreate, ')
          ..write('dateUpdate: $dateUpdate')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $KangooListTableTable kangooListTable =
      $KangooListTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [kangooListTable];
}

typedef $$KangooListTableTableInsertCompanionBuilder = KangooListTableCompanion
    Function({
  Value<int> id,
  required String name,
  required String obs,
  required DateTime dateCreate,
  required DateTime dateUpdate,
});
typedef $$KangooListTableTableUpdateCompanionBuilder = KangooListTableCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<String> obs,
  Value<DateTime> dateCreate,
  Value<DateTime> dateUpdate,
});

class $$KangooListTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $KangooListTableTable,
    KangooListTableData,
    $$KangooListTableTableFilterComposer,
    $$KangooListTableTableOrderingComposer,
    $$KangooListTableTableProcessedTableManager,
    $$KangooListTableTableInsertCompanionBuilder,
    $$KangooListTableTableUpdateCompanionBuilder> {
  $$KangooListTableTableTableManager(
      _$AppDatabase db, $KangooListTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$KangooListTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$KangooListTableTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$KangooListTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> obs = const Value.absent(),
            Value<DateTime> dateCreate = const Value.absent(),
            Value<DateTime> dateUpdate = const Value.absent(),
          }) =>
              KangooListTableCompanion(
            id: id,
            name: name,
            obs: obs,
            dateCreate: dateCreate,
            dateUpdate: dateUpdate,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String obs,
            required DateTime dateCreate,
            required DateTime dateUpdate,
          }) =>
              KangooListTableCompanion.insert(
            id: id,
            name: name,
            obs: obs,
            dateCreate: dateCreate,
            dateUpdate: dateUpdate,
          ),
        ));
}

class $$KangooListTableTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $KangooListTableTable,
    KangooListTableData,
    $$KangooListTableTableFilterComposer,
    $$KangooListTableTableOrderingComposer,
    $$KangooListTableTableProcessedTableManager,
    $$KangooListTableTableInsertCompanionBuilder,
    $$KangooListTableTableUpdateCompanionBuilder> {
  $$KangooListTableTableProcessedTableManager(super.$state);
}

class $$KangooListTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $KangooListTableTable> {
  $$KangooListTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get obs => $state.composableBuilder(
      column: $state.table.obs,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get dateCreate => $state.composableBuilder(
      column: $state.table.dateCreate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get dateUpdate => $state.composableBuilder(
      column: $state.table.dateUpdate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$KangooListTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $KangooListTableTable> {
  $$KangooListTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get obs => $state.composableBuilder(
      column: $state.table.obs,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get dateCreate => $state.composableBuilder(
      column: $state.table.dateCreate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get dateUpdate => $state.composableBuilder(
      column: $state.table.dateUpdate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$KangooListTableTableTableManager get kangooListTable =>
      $$KangooListTableTableTableManager(_db, _db.kangooListTable);
}
