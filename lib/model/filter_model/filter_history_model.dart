class FilterHistoryModel {
  final bool? favorite;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? statusId;

  const FilterHistoryModel({
    this.favorite,
    this.startDate,
    this.endDate,
    this.statusId,
  });

  FilterModelResult toStringFilterQUery(String tableName,
      {String? columnFavorite, String? columnStatusId}) {
    // DateTime still under construction.
    Map<String, Object?> listOfValue = {};

    if (columnFavorite != null && favorite != null) {
      listOfValue["$tableName.$columnFavorite"] = favorite! ? 1 : 0;
    }

    if (columnStatusId != null && statusId != null) {
      listOfValue["$tableName.$columnStatusId"] = statusId;
    }

    final listColumen = listOfValue.keys.map((e) => "$e = ?").toList();
    var whereQuery = " WHERE ${listColumen.join(' AND ')}";
    
    final argument = listOfValue.values.where((e) => e != null).toList();
    return FilterModelResult(
      whereQuery: whereQuery,
      argument: argument,
    );
  }

  @override
  String toString() {
    return 'FilterHistoryModel(favorite: $favorite, startDate: $startDate, endDate: $endDate, statusId: $statusId)';
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
