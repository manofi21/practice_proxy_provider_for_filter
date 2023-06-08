part of 'setup_db.dart';

Future<void> initTables({
  required Database db,
  required int version,
}) async {
  await db.transaction(
    (txn) async {
      // Create Watch table
      await WatchingModelV1.initTable(txn);
      await WatchTypeModelV1.initTable(txn);
      await WatchStatusModelV1.initTable(txn);

      // Create Read table
      await ReadingModelV1.initTable(txn);
      await ReadTypeModelV1.initTable(txn);
      await ReadStatusModelV1.initTable(txn);

      // Create Gaming table
      await GamingModelV1.initTable(txn);
      await GameTypeModelV1.initTable(txn);
      await GameStatusModelV1.initTable(txn);

      // init Watch list
      await txn.insert(
        WatchingModelV1.table,
        const WatchingModelV1(
          name: "Toaru Majutsu No Index",
          isFavorite: 1,
          idStatusWatch: "WS003",
          idTypeWatch: "WT002",
        ).toMap(),
      );

      // init Watch Type value
      await txn.insert(
        WatchTypeModelV1.table,
        const WatchTypeModelV1(id: "WT001", nameType: "Movie").toMap(),
      );
      await txn.insert(
        WatchTypeModelV1.table,
        const WatchTypeModelV1(id: "WT002", nameType: "Series").toMap(),
      );

      // init Watch status value
      await txn.insert(
        WatchStatusModelV1.table,
        const WatchStatusModelV1(id: "WS001", nameStatus: "Not Watched yet")
            .toMap(),
      );
      await txn.insert(
        WatchStatusModelV1.table,
        const WatchStatusModelV1(id: "WS002", nameStatus: "Not Completed yet")
            .toMap(),
      );
      await txn.insert(
        WatchStatusModelV1.table,
        const WatchStatusModelV1(id: "WS003", nameStatus: "Already Complete")
            .toMap(),
      );

      // init Read Type value
      await txn.insert(
        ReadTypeModelV1.table,
        const ReadTypeModelV1(id: "RT001", nameType: "Novel").toMap(),
      );
      await txn.insert(
        ReadTypeModelV1.table,
        const ReadTypeModelV1(id: "RT002", nameType: "Comic").toMap(),
      );
      await txn.insert(
        ReadTypeModelV1.table,
        const ReadTypeModelV1(id: "RT003", nameType: "Non-fiction").toMap(),
      );

      // init Read Status value
      await txn.insert(
        ReadStatusModelV1.table,
        const ReadStatusModelV1(id: "RS001", nameStatus: "Not Readed yet")
            .toMap(),
      );
      await txn.insert(
        ReadStatusModelV1.table,
        const ReadStatusModelV1(id: "RS002", nameStatus: "Not Completed yet")
            .toMap(),
      );
      await txn.insert(
        ReadStatusModelV1.table,
        const ReadStatusModelV1(id: "RS003", nameStatus: "Already Complete")
            .toMap(),
      );

      // init Game Type value
      await txn.insert(
        GameTypeModelV1.table,
        const GameTypeModelV1(id: "GT001", nameType: "Mobile Game").toMap(),
      );
      await txn.insert(
        GameTypeModelV1.table,
        const GameTypeModelV1(id: "GT002", nameType: "PC Game").toMap(),
      );
      await txn.insert(
        GameTypeModelV1.table,
        const GameTypeModelV1(id: "GT003", nameType: "Console Game").toMap(),
      );
      await txn.insert(
        GameTypeModelV1.table,
        const GameTypeModelV1(id: "GT004", nameType: "Arcade").toMap(),
      );

      // init Game Status value
      await txn.insert(
        GameStatusModelV1.table,
        const GameStatusModelV1(id: "GS001", nameStatus: "Not Played yet")
            .toMap(),
      );
      await txn.insert(
        GameStatusModelV1.table,
        const GameStatusModelV1(id: "GS002", nameStatus: "Not Completed yet")
            .toMap(),
      );
      await txn.insert(
        GameStatusModelV1.table,
        const GameStatusModelV1(id: "GS003", nameStatus: "Already Complete")
            .toMap(),
      );
    },
  );
}
