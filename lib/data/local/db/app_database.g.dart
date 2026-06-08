// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LocationLocalTableTable extends LocationLocalTable
    with TableInfo<$LocationLocalTableTable, LocationLocalTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;

  $LocationLocalTableTable(this.attachedDatabase, [this._alias]);

  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<String> lat = GeneratedColumn<String>(
    'lat',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lngMeta = const VerificationMeta('lng');
  @override
  late final GeneratedColumn<String> lng = GeneratedColumn<String>(
    'lng',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accuracyMeta = const VerificationMeta('accuracy');
  @override
  late final GeneratedColumn<String> accuracy = GeneratedColumn<String>(
    'accuracy',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<int> timestamp = GeneratedColumn<int>(
    'timestamp',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );

  @override
  List<GeneratedColumn> get $columns => [id, lat, lng, accuracy, timestamp];

  @override
  String get aliasedName => _alias ?? actualTableName;

  @override
  String get actualTableName => $name;
  static const String $name = 'location_local_table';

  @override
  VerificationContext validateIntegrity(Insertable<LocationLocalTableData> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lat')) {
      context.handle(_latMeta, lat.isAcceptableOrUnknown(data['lat']!, _latMeta));
    }
    if (data.containsKey('lng')) {
      context.handle(_lngMeta, lng.isAcceptableOrUnknown(data['lng']!, _lngMeta));
    }
    if (data.containsKey('accuracy')) {
      context.handle(_accuracyMeta, accuracy.isAcceptableOrUnknown(data['accuracy']!, _accuracyMeta));
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta, timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  @override
  LocationLocalTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocationLocalTableData(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      lat: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}lat']),
      lng: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}lng']),
      accuracy: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}accuracy']),
      timestamp: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}timestamp']),
    );
  }

  @override
  $LocationLocalTableTable createAlias(String alias) {
    return $LocationLocalTableTable(attachedDatabase, alias);
  }
}

class LocationLocalTableData extends DataClass implements Insertable<LocationLocalTableData> {
  final int id;
  final String? lat;
  final String? lng;
  final String? accuracy;
  final int? timestamp;

  const LocationLocalTableData({required this.id, this.lat, this.lng, this.accuracy, this.timestamp});

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || lat != null) {
      map['lat'] = Variable<String>(lat);
    }
    if (!nullToAbsent || lng != null) {
      map['lng'] = Variable<String>(lng);
    }
    if (!nullToAbsent || accuracy != null) {
      map['accuracy'] = Variable<String>(accuracy);
    }
    if (!nullToAbsent || timestamp != null) {
      map['timestamp'] = Variable<int>(timestamp);
    }
    return map;
  }

  LocationLocalTableCompanion toCompanion(bool nullToAbsent) {
    return LocationLocalTableCompanion(
      id: Value(id),
      lat: lat == null && nullToAbsent ? const Value.absent() : Value(lat),
      lng: lng == null && nullToAbsent ? const Value.absent() : Value(lng),
      accuracy: accuracy == null && nullToAbsent ? const Value.absent() : Value(accuracy),
      timestamp: timestamp == null && nullToAbsent ? const Value.absent() : Value(timestamp),
    );
  }

  factory LocationLocalTableData.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocationLocalTableData(
      id: serializer.fromJson<int>(json['id']),
      lat: serializer.fromJson<String?>(json['lat']),
      lng: serializer.fromJson<String?>(json['lng']),
      accuracy: serializer.fromJson<String?>(json['accuracy']),
      timestamp: serializer.fromJson<int?>(json['timestamp']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lat': serializer.toJson<String?>(lat),
      'lng': serializer.toJson<String?>(lng),
      'accuracy': serializer.toJson<String?>(accuracy),
      'timestamp': serializer.toJson<int?>(timestamp),
    };
  }

  LocationLocalTableData copyWith({
    int? id,
    Value<String?> lat = const Value.absent(),
    Value<String?> lng = const Value.absent(),
    Value<String?> accuracy = const Value.absent(),
    Value<int?> timestamp = const Value.absent(),
  }) => LocationLocalTableData(
    id: id ?? this.id,
    lat: lat.present ? lat.value : this.lat,
    lng: lng.present ? lng.value : this.lng,
    accuracy: accuracy.present ? accuracy.value : this.accuracy,
    timestamp: timestamp.present ? timestamp.value : this.timestamp,
  );

  LocationLocalTableData copyWithCompanion(LocationLocalTableCompanion data) {
    return LocationLocalTableData(
      id: data.id.present ? data.id.value : this.id,
      lat: data.lat.present ? data.lat.value : this.lat,
      lng: data.lng.present ? data.lng.value : this.lng,
      accuracy: data.accuracy.present ? data.accuracy.value : this.accuracy,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocationLocalTableData(')
          ..write('id: $id, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('accuracy: $accuracy, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lat, lng, accuracy, timestamp);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocationLocalTableData &&
          other.id == this.id &&
          other.lat == this.lat &&
          other.lng == this.lng &&
          other.accuracy == this.accuracy &&
          other.timestamp == this.timestamp);
}

class LocationLocalTableCompanion extends UpdateCompanion<LocationLocalTableData> {
  final Value<int> id;
  final Value<String?> lat;
  final Value<String?> lng;
  final Value<String?> accuracy;
  final Value<int?> timestamp;

  const LocationLocalTableCompanion({
    this.id = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.timestamp = const Value.absent(),
  });

  LocationLocalTableCompanion.insert({
    this.id = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.timestamp = const Value.absent(),
  });

  static Insertable<LocationLocalTableData> custom({
    Expression<int>? id,
    Expression<String>? lat,
    Expression<String>? lng,
    Expression<String>? accuracy,
    Expression<int>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
      if (accuracy != null) 'accuracy': accuracy,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  LocationLocalTableCompanion copyWith({
    Value<int>? id,
    Value<String?>? lat,
    Value<String?>? lng,
    Value<String?>? accuracy,
    Value<int?>? timestamp,
  }) {
    return LocationLocalTableCompanion(
      id: id ?? this.id,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      accuracy: accuracy ?? this.accuracy,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lat.present) {
      map['lat'] = Variable<String>(lat.value);
    }
    if (lng.present) {
      map['lng'] = Variable<String>(lng.value);
    }
    if (accuracy.present) {
      map['accuracy'] = Variable<String>(accuracy.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationLocalTableCompanion(')
          ..write('id: $id, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('accuracy: $accuracy, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);

  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocationLocalTableTable locationLocalTable = $LocationLocalTableTable(this);

  @override
  Iterable<TableInfo<Table, Object?>> get allTables => allSchemaEntities.whereType<TableInfo<Table, Object?>>();

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [locationLocalTable];
}

typedef $$LocationLocalTableTableCreateCompanionBuilder =
    LocationLocalTableCompanion Function({
      Value<int> id,
      Value<String?> lat,
      Value<String?> lng,
      Value<String?> accuracy,
      Value<int?> timestamp,
    });
typedef $$LocationLocalTableTableUpdateCompanionBuilder =
    LocationLocalTableCompanion Function({
      Value<int> id,
      Value<String?> lat,
      Value<String?> lng,
      Value<String?> accuracy,
      Value<int?> timestamp,
    });

class $$LocationLocalTableTableFilterComposer extends Composer<_$AppDatabase, $LocationLocalTableTable> {
  $$LocationLocalTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });

  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lng =>
      $composableBuilder(column: $table.lng, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get accuracy =>
      $composableBuilder(column: $table.accuracy, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => ColumnFilters(column));
}

class $$LocationLocalTableTableOrderingComposer extends Composer<_$AppDatabase, $LocationLocalTableTable> {
  $$LocationLocalTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });

  ColumnOrderings<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lng =>
      $composableBuilder(column: $table.lng, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get accuracy =>
      $composableBuilder(column: $table.accuracy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => ColumnOrderings(column));
}

class $$LocationLocalTableTableAnnotationComposer extends Composer<_$AppDatabase, $LocationLocalTableTable> {
  $$LocationLocalTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });

  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get lat => $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<String> get lng => $composableBuilder(column: $table.lng, builder: (column) => column);

  GeneratedColumn<String> get accuracy => $composableBuilder(column: $table.accuracy, builder: (column) => column);

  GeneratedColumn<int> get timestamp => $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $$LocationLocalTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocationLocalTableTable,
          LocationLocalTableData,
          $$LocationLocalTableTableFilterComposer,
          $$LocationLocalTableTableOrderingComposer,
          $$LocationLocalTableTableAnnotationComposer,
          $$LocationLocalTableTableCreateCompanionBuilder,
          $$LocationLocalTableTableUpdateCompanionBuilder,
          (
            LocationLocalTableData,
            BaseReferences<_$AppDatabase, $LocationLocalTableTable, LocationLocalTableData>,
          ),
          LocationLocalTableData,
          PrefetchHooks Function()
        > {
  $$LocationLocalTableTableTableManager(_$AppDatabase db, $LocationLocalTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$LocationLocalTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$LocationLocalTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$LocationLocalTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> lat = const Value.absent(),
                Value<String?> lng = const Value.absent(),
                Value<String?> accuracy = const Value.absent(),
                Value<int?> timestamp = const Value.absent(),
              }) => LocationLocalTableCompanion(
                id: id,
                lat: lat,
                lng: lng,
                accuracy: accuracy,
                timestamp: timestamp,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> lat = const Value.absent(),
                Value<String?> lng = const Value.absent(),
                Value<String?> accuracy = const Value.absent(),
                Value<int?> timestamp = const Value.absent(),
              }) => LocationLocalTableCompanion.insert(
                id: id,
                lat: lat,
                lng: lng,
                accuracy: accuracy,
                timestamp: timestamp,
              ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocationLocalTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocationLocalTableTable,
      LocationLocalTableData,
      $$LocationLocalTableTableFilterComposer,
      $$LocationLocalTableTableOrderingComposer,
      $$LocationLocalTableTableAnnotationComposer,
      $$LocationLocalTableTableCreateCompanionBuilder,
      $$LocationLocalTableTableUpdateCompanionBuilder,
      (LocationLocalTableData, BaseReferences<_$AppDatabase, $LocationLocalTableTable, LocationLocalTableData>),
      LocationLocalTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;

  $AppDatabaseManager(this._db);

  $$LocationLocalTableTableTableManager get locationLocalTable =>
      $$LocationLocalTableTableTableManager(_db, _db.locationLocalTable);
}
