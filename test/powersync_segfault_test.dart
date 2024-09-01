import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:powersync/powersync.dart';
import 'package:powersync/src/database/native/native_powersync_database.dart';
import 'package:path/path.dart';
import 'package:powersync/sqlite_async.dart';

final sqliteBinPath = const String.fromEnvironment("SQLITE_BIN").trim();

const schema = Schema([
  Table('users', [
    Column.text('email'),
    Column.text('hashed_password'),
    Column.text('confirmed_at'),
    Column.text('first_name'),
    Column.text('last_name'),
    Column.text('inserted_at'),
    Column.text('updated_at')
  ]),
]);

void main() {
  group("debug powersync", () {
    test("teardown powersync", () async {
      final basepath = await Directory.systemTemp.createTemp("example");
      final dbPath = join(basepath.path, 'test_database.db');
      final db = SqliteDatabase(path: dbPath);
      final powersyncDb = PowerSyncDatabaseImpl.withDatabase(schema: schema, database: db);

      print("tearing down");
      await powersyncDb.close();
      print("closed powersync");
    });
  });
}
