// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sqflite/sqflite.dart';

import '../utils/convert_type.dart';

class WatchingModelV1 {
  final int? id;
  final String name;
  final int isFavorite;
  final String idTypeWatch;
  final String idStatusWatch;

  const WatchingModelV1({
    this.id,
    required this.name,
    required this.isFavorite,
    required this.idTypeWatch,
    required this.idStatusWatch,
  });

  static const String table = "watching_table";
  static const String keyidtable = "id_table";
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
          $keyidtype text not null,
          $keyidstatus text not null
        )
      ''',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      keyid: id,
      keyname: name,
      keyfavorite: isFavorite,
      keyidtype: idTypeWatch,
      keyidstatus: idStatusWatch,
    };
  }

  factory WatchingModelV1.fromMap(Map<String, dynamic> map) {
    return WatchingModelV1(
      id: convertType<int>(map[keyid]) ?? 0,
      name: convertType<String>(map[keyname]) ?? '',
      isFavorite: convertType<int>(map[keyfavorite]) ?? 0,
      idTypeWatch: convertType<String>(map[keyidtype]) ?? '',
      idStatusWatch: convertType<String>(map[keyidstatus]) ?? '',
    );
  }
}
