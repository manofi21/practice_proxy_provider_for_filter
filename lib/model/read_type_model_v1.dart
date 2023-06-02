import 'package:sqflite/sqflite.dart';

import '../utils/convert_type.dart';

class ReadTypeModelV1 {
  final String id;
  final String nameType;

  const ReadTypeModelV1({
    required this.id,
    required this.nameType,
  });

  static const String table = "read_type_table";
  static const String keyid = "id";
  static const String keynametype = "name_type";

  static Future<void> initTable(Transaction txn) async {
    return txn.execute(
      '''
        create table $table 
        (
          no text primary key AUTOINCREMENT not null,
          $keyid text not null,
          $keynametype text not null
        )
      ''',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      keyid: id,
      keynametype: nameType,
    };
  }

  factory ReadTypeModelV1.fromMap(Map<String, dynamic> map) {
    return ReadTypeModelV1(
      id: convertType<String>(map[keyid]) ?? '',
      nameType: convertType<String>(map[keynametype]) ?? '',
    );
  }
}
