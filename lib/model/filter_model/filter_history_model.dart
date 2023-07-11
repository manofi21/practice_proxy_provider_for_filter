class FilterHistoryModel {
  final bool? favorite;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? statusId;
  final String? typeId;

  const FilterHistoryModel({
    this.favorite,
    this.startDate,
    this.endDate,
    this.statusId,
    this.typeId,
  });

  /// columnUpdateAt under constructor
  FilterModelResult toStringFilterQUery(
    String tableName, {
    String? columnFavorite,
    String? columnStatusId,
    String? columnTypeId,
    String? columnCreateAt,
    // String? columnUpdateAt,
  }) {
    // DateTime still under construction.
    Map<String, Object?> listOfValue = {};

    if (columnFavorite != null && favorite != null) {
      listOfValue["$tableName.$columnFavorite"] = favorite! ? 1 : 0;
    }

    if (columnStatusId != null && statusId != null) {
      listOfValue["$tableName.$columnStatusId"] = statusId;
    }

    if (columnTypeId != null && typeId != null) {
      listOfValue["$tableName.$columnTypeId"] = typeId;
    }

    final listColumen = listOfValue.keys.map((e) => "$e = ?").toList();
    var whereQuery = " WHERE ${listColumen.join(' AND ')}";
    final argument = listOfValue.values.where((e) => e != null).toList();
    
    if (startDate != null && columnCreateAt != null) {
      if (argument.isNotEmpty) {
        whereQuery += "AND ";
      }

      whereQuery += "$tableName.$columnCreateAt >= ?";
      argument.add(startDate!.millisecondsSinceEpoch);

      if (endDate == null) {
        final now = DateTime.now();
        final changeToEnd = DateTime(now.year, now.month, now.year, 23, 59, 59, 999);
        whereQuery += "AND $tableName.$columnCreateAt <= ?";
        argument.add(changeToEnd.millisecondsSinceEpoch);
      }
    }

    if (endDate != null && columnCreateAt != null) {
      if (argument.isNotEmpty) {
        whereQuery += "AND ";
      }

      whereQuery += "$tableName.$columnCreateAt <= ?";
      argument.add(endDate!.millisecondsSinceEpoch);
    }

    
    return FilterModelResult(
      whereQuery: whereQuery,
      argument: argument,
    );
  }

  @override
  String toString() {
    return 'FilterHistoryModel(favorite: $favorite, startDate: $startDate, endDate: $endDate, statusId: $statusId, typeId: $typeId)';
  }
}

class FilterModelResult {
  final String whereQuery;
  final List<Object?> argument;

  FilterModelResult({
    required this.whereQuery,
    required this.argument,
  });
}
