// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FaceUsersTable extends FaceUsers
    with TableInfo<$FaceUsersTable, FaceUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FaceUsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _faceImagePathMeta = const VerificationMeta(
    'faceImagePath',
  );
  @override
  late final GeneratedColumn<String> faceImagePath = GeneratedColumn<String>(
    'face_image_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<double>, String> embedding =
      GeneratedColumn<String>(
        'embedding',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<double>>($FaceUsersTable.$converterembedding);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    faceImagePath,
    embedding,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'face_users';
  @override
  VerificationContext validateIntegrity(
    Insertable<FaceUser> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('face_image_path')) {
      context.handle(
        _faceImagePathMeta,
        faceImagePath.isAcceptableOrUnknown(
          data['face_image_path']!,
          _faceImagePathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_faceImagePathMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FaceUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FaceUser(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      faceImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}face_image_path'],
      )!,
      embedding: $FaceUsersTable.$converterembedding.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}embedding'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FaceUsersTable createAlias(String alias) {
    return $FaceUsersTable(attachedDatabase, alias);
  }

  static TypeConverter<List<double>, String> $converterembedding =
      const DoubleListConverter();
}

class FaceUser extends DataClass implements Insertable<FaceUser> {
  final int id;
  final String name;

  /// Local path to cropped face image
  final String faceImagePath;

  /// Face embedding (192 floats, JSON-encoded)
  final List<double> embedding;
  final DateTime createdAt;
  const FaceUser({
    required this.id,
    required this.name,
    required this.faceImagePath,
    required this.embedding,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['face_image_path'] = Variable<String>(faceImagePath);
    {
      map['embedding'] = Variable<String>(
        $FaceUsersTable.$converterembedding.toSql(embedding),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FaceUsersCompanion toCompanion(bool nullToAbsent) {
    return FaceUsersCompanion(
      id: Value(id),
      name: Value(name),
      faceImagePath: Value(faceImagePath),
      embedding: Value(embedding),
      createdAt: Value(createdAt),
    );
  }

  factory FaceUser.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FaceUser(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      faceImagePath: serializer.fromJson<String>(json['faceImagePath']),
      embedding: serializer.fromJson<List<double>>(json['embedding']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'faceImagePath': serializer.toJson<String>(faceImagePath),
      'embedding': serializer.toJson<List<double>>(embedding),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FaceUser copyWith({
    int? id,
    String? name,
    String? faceImagePath,
    List<double>? embedding,
    DateTime? createdAt,
  }) => FaceUser(
    id: id ?? this.id,
    name: name ?? this.name,
    faceImagePath: faceImagePath ?? this.faceImagePath,
    embedding: embedding ?? this.embedding,
    createdAt: createdAt ?? this.createdAt,
  );
  FaceUser copyWithCompanion(FaceUsersCompanion data) {
    return FaceUser(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      faceImagePath: data.faceImagePath.present
          ? data.faceImagePath.value
          : this.faceImagePath,
      embedding: data.embedding.present ? data.embedding.value : this.embedding,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FaceUser(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('faceImagePath: $faceImagePath, ')
          ..write('embedding: $embedding, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, faceImagePath, embedding, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FaceUser &&
          other.id == this.id &&
          other.name == this.name &&
          other.faceImagePath == this.faceImagePath &&
          other.embedding == this.embedding &&
          other.createdAt == this.createdAt);
}

class FaceUsersCompanion extends UpdateCompanion<FaceUser> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> faceImagePath;
  final Value<List<double>> embedding;
  final Value<DateTime> createdAt;
  const FaceUsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.faceImagePath = const Value.absent(),
    this.embedding = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FaceUsersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String faceImagePath,
    required List<double> embedding,
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       faceImagePath = Value(faceImagePath),
       embedding = Value(embedding);
  static Insertable<FaceUser> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? faceImagePath,
    Expression<String>? embedding,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (faceImagePath != null) 'face_image_path': faceImagePath,
      if (embedding != null) 'embedding': embedding,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FaceUsersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? faceImagePath,
    Value<List<double>>? embedding,
    Value<DateTime>? createdAt,
  }) {
    return FaceUsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      faceImagePath: faceImagePath ?? this.faceImagePath,
      embedding: embedding ?? this.embedding,
      createdAt: createdAt ?? this.createdAt,
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
    if (faceImagePath.present) {
      map['face_image_path'] = Variable<String>(faceImagePath.value);
    }
    if (embedding.present) {
      map['embedding'] = Variable<String>(
        $FaceUsersTable.$converterembedding.toSql(embedding.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FaceUsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('faceImagePath: $faceImagePath, ')
          ..write('embedding: $embedding, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AttendanceTableTable extends AttendanceTable
    with TableInfo<$AttendanceTableTable, AttendanceTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttendanceTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES face_users (id)',
    ),
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, userId, timestamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attendance_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AttendanceTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AttendanceTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttendanceTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
    );
  }

  @override
  $AttendanceTableTable createAlias(String alias) {
    return $AttendanceTableTable(attachedDatabase, alias);
  }
}

class AttendanceTableData extends DataClass
    implements Insertable<AttendanceTableData> {
  final int id;
  final int userId;
  final DateTime timestamp;
  const AttendanceTableData({
    required this.id,
    required this.userId,
    required this.timestamp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  AttendanceTableCompanion toCompanion(bool nullToAbsent) {
    return AttendanceTableCompanion(
      id: Value(id),
      userId: Value(userId),
      timestamp: Value(timestamp),
    );
  }

  factory AttendanceTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttendanceTableData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  AttendanceTableData copyWith({int? id, int? userId, DateTime? timestamp}) =>
      AttendanceTableData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        timestamp: timestamp ?? this.timestamp,
      );
  AttendanceTableData copyWithCompanion(AttendanceTableCompanion data) {
    return AttendanceTableData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceTableData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttendanceTableData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.timestamp == this.timestamp);
}

class AttendanceTableCompanion extends UpdateCompanion<AttendanceTableData> {
  final Value<int> id;
  final Value<int> userId;
  final Value<DateTime> timestamp;
  const AttendanceTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  AttendanceTableCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    this.timestamp = const Value.absent(),
  }) : userId = Value(userId);
  static Insertable<AttendanceTableData> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<DateTime>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  AttendanceTableCompanion copyWith({
    Value<int>? id,
    Value<int>? userId,
    Value<DateTime>? timestamp,
  }) {
    return AttendanceTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FaceUsersTable faceUsers = $FaceUsersTable(this);
  late final $AttendanceTableTable attendanceTable = $AttendanceTableTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    faceUsers,
    attendanceTable,
  ];
}

typedef $$FaceUsersTableCreateCompanionBuilder =
    FaceUsersCompanion Function({
      Value<int> id,
      required String name,
      required String faceImagePath,
      required List<double> embedding,
      Value<DateTime> createdAt,
    });
typedef $$FaceUsersTableUpdateCompanionBuilder =
    FaceUsersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> faceImagePath,
      Value<List<double>> embedding,
      Value<DateTime> createdAt,
    });

final class $$FaceUsersTableReferences
    extends BaseReferences<_$AppDatabase, $FaceUsersTable, FaceUser> {
  $$FaceUsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AttendanceTableTable, List<AttendanceTableData>>
  _attendanceTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.attendanceTable,
    aliasName: $_aliasNameGenerator(db.faceUsers.id, db.attendanceTable.userId),
  );

  $$AttendanceTableTableProcessedTableManager get attendanceTableRefs {
    final manager = $$AttendanceTableTableTableManager(
      $_db,
      $_db.attendanceTable,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _attendanceTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FaceUsersTableFilterComposer
    extends Composer<_$AppDatabase, $FaceUsersTable> {
  $$FaceUsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get faceImagePath => $composableBuilder(
    column: $table.faceImagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<double>, List<double>, String>
  get embedding => $composableBuilder(
    column: $table.embedding,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> attendanceTableRefs(
    Expression<bool> Function($$AttendanceTableTableFilterComposer f) f,
  ) {
    final $$AttendanceTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attendanceTable,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttendanceTableTableFilterComposer(
            $db: $db,
            $table: $db.attendanceTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FaceUsersTableOrderingComposer
    extends Composer<_$AppDatabase, $FaceUsersTable> {
  $$FaceUsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get faceImagePath => $composableBuilder(
    column: $table.faceImagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get embedding => $composableBuilder(
    column: $table.embedding,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FaceUsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $FaceUsersTable> {
  $$FaceUsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get faceImagePath => $composableBuilder(
    column: $table.faceImagePath,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<double>, String> get embedding =>
      $composableBuilder(column: $table.embedding, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> attendanceTableRefs<T extends Object>(
    Expression<T> Function($$AttendanceTableTableAnnotationComposer a) f,
  ) {
    final $$AttendanceTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attendanceTable,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttendanceTableTableAnnotationComposer(
            $db: $db,
            $table: $db.attendanceTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FaceUsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FaceUsersTable,
          FaceUser,
          $$FaceUsersTableFilterComposer,
          $$FaceUsersTableOrderingComposer,
          $$FaceUsersTableAnnotationComposer,
          $$FaceUsersTableCreateCompanionBuilder,
          $$FaceUsersTableUpdateCompanionBuilder,
          (FaceUser, $$FaceUsersTableReferences),
          FaceUser,
          PrefetchHooks Function({bool attendanceTableRefs})
        > {
  $$FaceUsersTableTableManager(_$AppDatabase db, $FaceUsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FaceUsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FaceUsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FaceUsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> faceImagePath = const Value.absent(),
                Value<List<double>> embedding = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FaceUsersCompanion(
                id: id,
                name: name,
                faceImagePath: faceImagePath,
                embedding: embedding,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String faceImagePath,
                required List<double> embedding,
                Value<DateTime> createdAt = const Value.absent(),
              }) => FaceUsersCompanion.insert(
                id: id,
                name: name,
                faceImagePath: faceImagePath,
                embedding: embedding,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FaceUsersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({attendanceTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (attendanceTableRefs) db.attendanceTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (attendanceTableRefs)
                    await $_getPrefetchedData<
                      FaceUser,
                      $FaceUsersTable,
                      AttendanceTableData
                    >(
                      currentTable: table,
                      referencedTable: $$FaceUsersTableReferences
                          ._attendanceTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$FaceUsersTableReferences(
                            db,
                            table,
                            p0,
                          ).attendanceTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.userId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$FaceUsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FaceUsersTable,
      FaceUser,
      $$FaceUsersTableFilterComposer,
      $$FaceUsersTableOrderingComposer,
      $$FaceUsersTableAnnotationComposer,
      $$FaceUsersTableCreateCompanionBuilder,
      $$FaceUsersTableUpdateCompanionBuilder,
      (FaceUser, $$FaceUsersTableReferences),
      FaceUser,
      PrefetchHooks Function({bool attendanceTableRefs})
    >;
typedef $$AttendanceTableTableCreateCompanionBuilder =
    AttendanceTableCompanion Function({
      Value<int> id,
      required int userId,
      Value<DateTime> timestamp,
    });
typedef $$AttendanceTableTableUpdateCompanionBuilder =
    AttendanceTableCompanion Function({
      Value<int> id,
      Value<int> userId,
      Value<DateTime> timestamp,
    });

final class $$AttendanceTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $AttendanceTableTable,
          AttendanceTableData
        > {
  $$AttendanceTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FaceUsersTable _userIdTable(_$AppDatabase db) =>
      db.faceUsers.createAlias(
        $_aliasNameGenerator(db.attendanceTable.userId, db.faceUsers.id),
      );

  $$FaceUsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$FaceUsersTableTableManager(
      $_db,
      $_db.faceUsers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AttendanceTableTableFilterComposer
    extends Composer<_$AppDatabase, $AttendanceTableTable> {
  $$AttendanceTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  $$FaceUsersTableFilterComposer get userId {
    final $$FaceUsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.faceUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FaceUsersTableFilterComposer(
            $db: $db,
            $table: $db.faceUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttendanceTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AttendanceTableTable> {
  $$AttendanceTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  $$FaceUsersTableOrderingComposer get userId {
    final $$FaceUsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.faceUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FaceUsersTableOrderingComposer(
            $db: $db,
            $table: $db.faceUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttendanceTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttendanceTableTable> {
  $$AttendanceTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  $$FaceUsersTableAnnotationComposer get userId {
    final $$FaceUsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.faceUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FaceUsersTableAnnotationComposer(
            $db: $db,
            $table: $db.faceUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttendanceTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttendanceTableTable,
          AttendanceTableData,
          $$AttendanceTableTableFilterComposer,
          $$AttendanceTableTableOrderingComposer,
          $$AttendanceTableTableAnnotationComposer,
          $$AttendanceTableTableCreateCompanionBuilder,
          $$AttendanceTableTableUpdateCompanionBuilder,
          (AttendanceTableData, $$AttendanceTableTableReferences),
          AttendanceTableData,
          PrefetchHooks Function({bool userId})
        > {
  $$AttendanceTableTableTableManager(
    _$AppDatabase db,
    $AttendanceTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttendanceTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttendanceTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttendanceTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
              }) => AttendanceTableCompanion(
                id: id,
                userId: userId,
                timestamp: timestamp,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userId,
                Value<DateTime> timestamp = const Value.absent(),
              }) => AttendanceTableCompanion.insert(
                id: id,
                userId: userId,
                timestamp: timestamp,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AttendanceTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userId,
                                referencedTable:
                                    $$AttendanceTableTableReferences
                                        ._userIdTable(db),
                                referencedColumn:
                                    $$AttendanceTableTableReferences
                                        ._userIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AttendanceTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttendanceTableTable,
      AttendanceTableData,
      $$AttendanceTableTableFilterComposer,
      $$AttendanceTableTableOrderingComposer,
      $$AttendanceTableTableAnnotationComposer,
      $$AttendanceTableTableCreateCompanionBuilder,
      $$AttendanceTableTableUpdateCompanionBuilder,
      (AttendanceTableData, $$AttendanceTableTableReferences),
      AttendanceTableData,
      PrefetchHooks Function({bool userId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FaceUsersTableTableManager get faceUsers =>
      $$FaceUsersTableTableManager(_db, _db.faceUsers);
  $$AttendanceTableTableTableManager get attendanceTable =>
      $$AttendanceTableTableTableManager(_db, _db.attendanceTable);
}
