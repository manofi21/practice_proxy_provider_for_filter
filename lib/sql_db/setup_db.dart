import 'package:sqflite/sqflite.dart';

import '../model/game_status_model_v1.dart';
import '../model/game_type_model_v1.dart';
import '../model/gaming_model_v1.dart';
import '../model/read_status_model_v1.dart';
import '../model/read_type_model_v1.dart';
import '../model/reading_model_v1.dart';
import '../model/watch_status_model_v1.dart';
import '../model/watch_type_model_v1.dart';
import '../model/watching_model_v1.dart';

part 'init_table.dart';
part 'update_table.dart';


const int sqfLiteDatabaseVersion = 2;
const String sqfLiteDatabase = "database_hobby_activity_trakig.db";

Future<Database> getAndSetupDB() async {
    final db = await openDatabase(
    sqfLiteDatabase,
    version: sqfLiteDatabaseVersion,
    onCreate: (db, version) async {
      await initTables(
        db: db,
        version: version,
      );
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      await updateTables(
        db,
        oldVersion,
        newVersion,
      );
    },
  );
  return db;
}