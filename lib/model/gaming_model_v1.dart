// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sqflite/sqflite.dart';

import '../utils/convert_type.dart';
import 'base_model/base_model_v1.dart';

class GamingModelV1 extends BaseModelV1 {
  GamingModelV1({
    int? id,
    required String name,
    required int isFavorite,
    required String idTypeGame,
    required String idStatusGame,
    required int createAt,
    int? updateAt,
  }) : super(
          id: id,
          name: name,
          isFavorite: isFavorite,
          idType: idTypeGame,
          idStatus: idStatusGame,
          createAt: createAt,
          updateAt: updateAt,
        );

  static const String table = "gaming_table";
  static const String keyid = "id";
  static const String keyname = "name";
  static const String keyfavorite = "favorite";
  static const String keyidtype = "id_type";
  static const String keyidstatus = "id_status";
  static const String keycreateAt = "create_at";
  static const String keyupdateAt = "update_at";

  static Future<void> initTable(Transaction txn) async {
    return txn.execute(
      '''
        create table $table
        (
          $keyid integer primary key AUTOINCREMENT not null,
          $keyname text not null,
          $keyfavorite integer not null,
          $keyidtype text not null,
          $keyidstatus text not null,
          $keycreateAt integer not null,
          $keyupdateAt integer
        )
      ''',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      keyid: id,
      keyname: name,
      keyfavorite: isFavorite,
      keyidtype: idType,
      keyidstatus: idStatus,
      keycreateAt: createAt,
      keyupdateAt: updateAt,
    };
  }

  Map<String, dynamic> toUpdateMap() {
    return <String, dynamic>{
      keyname: name,
      keyfavorite: isFavorite,
      keyidtype: idType,
      keyidstatus: idStatus,
      keycreateAt: createAt,
      keyupdateAt: updateAt,
    };
  }

  factory GamingModelV1.fromMap(Map<String, dynamic> map) {
    return GamingModelV1(
      id: convertType<int>(map[keyid]) ?? 0,
      name: convertType<String>(map[keyname]) ?? '',
      isFavorite: convertType<int>(map[keyfavorite]) ?? 0,
      idTypeGame: convertType<String>(map[keyidtype]) ?? '',
      idStatusGame: convertType<String>(map[keyidstatus]) ?? '',
      createAt: convertType<int>(map[keycreateAt]) ?? 0,
      updateAt: convertType<int>(map[keyupdateAt]),
    );
  }
}
