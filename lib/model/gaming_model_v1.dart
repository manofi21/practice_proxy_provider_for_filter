// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sqflite/sqflite.dart';

import '../utils/convert_type.dart';

class GamingModelV1 {
  final int id;
  final String name;
  final int isFavorite;
  final int idTypeGame;
  final int idStatusGame;

  const GamingModelV1({
    required this.id,
    required this.name,
    required this.isFavorite,
    required this.idTypeGame,
    required this.idStatusGame,
  });

  static const String table = "gaming_table";
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
          $keyid text primary key AUTOINCREMENT not null,
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
      keyidtype: idTypeGame,
      keyidstatus: idStatusGame,
    };
  }

  factory GamingModelV1.fromMap(Map<String, dynamic> map) {
    return GamingModelV1(
      id: convertType<int>(map[keyid]) ?? 0,
      name: convertType<String>(map[keyname]) ?? '',
      isFavorite: convertType<int>(map[keyfavorite]) ?? 0,
      idTypeGame: convertType<int>(map[keyidtype]) ?? 0,
      idStatusGame: convertType<int>(map[keyidstatus]) ?? 0,
    );
  }
}
