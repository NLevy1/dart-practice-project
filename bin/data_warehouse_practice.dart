import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:collection/collection.dart';

void main() async {
  print('Creating DB');
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  await deleteDatabase('my_db.db'); //behaves like delete if exists

  Database db = await openDatabase(
    'my_db.db',
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)',
      );
    },
  );

  print('DB created');

  await db.transaction((txn) async {
    int id1 = await txn.rawInsert(
      "INSERT INTO Test(name, value, num) VALUES('some name', 1234, 456.789)",
    );
    print('inserted1: $id1');
    int id2 = await txn.rawInsert(
      'INSERT INTO Test(name, value, num) VALUES(?, ?, ?)',
      ['another name', 12345678, 3.1416],
    );
    print('inserted2: $id2');
  });

  int count = await db.rawUpdate(
    'UPDATE Test SET name = ?, value = ? WHERE name = ?',
    ['updated name', '9876', 'some name'],
  );
  print('updated: $count');

  List<Map> list = await db.rawQuery('SELECT * FROM Test');
  List<Map> expectedList = [
    {'name': 'updated name', 'id': 1, 'value': 9876, 'num': 456.789},
    {'name': 'another name', 'id': 2, 'value': 12345678, 'num': 3.1416},
  ];
  print(list);
  print(expectedList);
  if (const DeepCollectionEquality().equals(list, expectedList)) {
    print('Lists match!');
  } else {
    print('Lists differ!');
  }
}
