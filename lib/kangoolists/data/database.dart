import "dart:io";
import "package:drift/drift.dart";
import "package:flutter_kangoolist/kangoolists/models/kangoolist.dart";
import "package:path_provider/path_provider.dart";
import "package:path/path.dart" as path;
import "package:drift/native.dart";
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part "database.g.dart";

class KangooListTable extends Table {
  IntColumn get id => integer().named('id').autoIncrement()();
  TextColumn get name => text().named('name').withLength(min: 4, max: 30)();
  TextColumn get obs => text().named('obs')();
  DateTimeColumn get dateCreate => dateTime().named('dateCreate')();
  DateTimeColumn get dateUpdate => dateTime().named('dateUpdate')();
}

@DriftDatabase(tables: [KangooListTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> insertKangooList(KangooList kangooList) async {
    KangooListTableCompanion novaLinha = KangooListTableCompanion(
      name: Value(kangooList.name),
      obs: Value(kangooList.obs),
      dateCreate: Value(kangooList.dateCreate),
      dateUpdate: Value(kangooList.dateUpdate),
    );
    return await into(kangooListTable).insert(novaLinha);
  }

  Future<List<KangooList>> getKangooLists() async {
    List<KangooList> temp = [];

    List<KangooListTableData> listData = await select(kangooListTable).get();

    for (KangooListTableData row in listData) {
      temp.add(
        KangooList(
          id: row.id.toString(),
          name: row.name,
          obs: row.obs,
          dateCreate: row.dateCreate,
          dateUpdate: row.dateUpdate,
        ),
      );
    }
    return temp;
  }

  Future<bool> updateKangooList(KangooList kangooList) async {
    return await update(kangooListTable).replace(
      KangooListTableCompanion(
        id: Value(int.parse(kangooList.id)),
        name: Value(kangooList.name),
        obs: Value(kangooList.obs),
        dateCreate: Value(kangooList.dateCreate),
        dateUpdate: Value(kangooList.dateUpdate),
      ),
    );
  }

  Future<int> deleteKangooList(int id) async {
    return await (delete(kangooListTable)..where((row) => row.id.equals(id)))
        .go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(
    () async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(path.join(dbFolder.path, "db.sqlite"));

      if (Platform.isAndroid) {
        await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
      }

      return NativeDatabase.createInBackground(file);
    },
  );
}
