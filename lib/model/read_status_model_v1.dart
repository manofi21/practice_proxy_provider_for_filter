import 'package:sqflite/sqflite.dart';

import '../utils/convert_type.dart';

class ReadStatusModelV1 {
  final String id;
  final String nameStatus;

  const ReadStatusModelV1({
    required this.id,
    required this.nameStatus,
  });

  static const String table = "read_status_table";
  static const String keyid = "id";
  static const String keynamestatus = "name_status";

  static Future<void> initTable(Transaction txn) async {
    return txn.execute(
      '''
        create table $table 
        (
          no text primary key AUTOINCREMENT not null,
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

  factory ReadStatusModelV1.fromMap(Map<String, dynamic> map) {
    return ReadStatusModelV1(
      id: convertType<String>(map[keyid]) ?? '',
      nameStatus: convertType<String>(map[keynamestatus]) ?? '',
    );
  }
}
