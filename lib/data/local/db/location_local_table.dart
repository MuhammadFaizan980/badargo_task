import 'package:drift/drift.dart';

class LocationLocalTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get lat => text().nullable()();

  TextColumn get lng => text().nullable()();

  TextColumn get accuracy => text().nullable()();

  IntColumn get timestamp => integer().nullable()();
}
