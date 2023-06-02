import 'package:sqflite/sqflite.dart';

import '../utils/convert_type.dart';

class WatchStatusModelV1 {
  final String id;
  final String nameStatus;

  const WatchStatusModelV1({
    required this.id,
    required this.nameStatus,
  });

  static const String table = "watch_status_table";
  static const String keyid = "id";
  static const String keynamestatus = "name_status";

  static Future<void> initTable(Transaction txn) async {
    return txn.execute(
      '''
        create table $table 
        (
          no integer primary key AUTOINCREMENT not null,
          $keyid text not null,
          $keynamestatus text not null
        )
      ''',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      keyid: id,
      keynamestatus: nameStatus,
    };
  }

  factory WatchStatusModelV1.fromMap(Map<String, dynamic> map) {
    return WatchStatusModelV1(
      id: convertType<String>(map[keyid]) ?? '',
      nameStatus: convertType<String>(map[keynamestatus]) ?? '',
    );
  }
}
