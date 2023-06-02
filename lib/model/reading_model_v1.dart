// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sqflite/sqflite.dart';

import '../utils/convert_type.dart';

class ReadingModelV1 {
  final int id;
  final String name;
  final int isFavorite;
  final int idTypeRead;
  final int idStatusRead;

  const ReadingModelV1({
    required this.id,
    required this.name,
    required this.isFavorite,
    required this.idTypeRead,
    required this.idStatusRead,
  });

  static const String table = "reading_table";
  static const String keyid = "id";
  static const String keyname = "name";
  static const String keyfavorite = "favorite";
  static const String keyidtype = "id_type";
  static const String keyidstatus = "id_status";

  static Future<void> initTable(Transaction txn) async {
    return txn.execute(
      '''
        create table $table 
        (
          $keyid integer primary key AUTOINCREMENT not null,
          $keyname text not null,
          $keyfavorite integer not null,
          $keyidtype integer not null,
          $keyidstatus integer not null
        )
      ''',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      keyid: id,
      keyname: name,
      keyfavorite: isFavorite,
      keyidtype: idTypeRead,
      keyidstatus: idStatusRead,
    };
  }

  factory ReadingModelV1.fromMap(Map<String, dynamic> map) {
    return ReadingModelV1(
      id: convertType<int>(map[keyid]) ?? 0,
      name: convertType<String>(map[keyname]) ?? '',
      isFavorite: convertType<int>(map[keyfavorite]) ?? 0,
      idTypeRead: convertType<int>(map[keyidtype]) ?? 0,
      idStatusRead: convertType<int>(map[keyidstatus]) ?? 0,
    );
  }
}
