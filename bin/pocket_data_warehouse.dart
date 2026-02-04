import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
    print('Creating DB');
sqfliteFfiInit();
databaseFactory = databaseFactoryFfi;

var db = await openDatabase('my_db.db', version: 1, onCreate: (Database db, int version) async {
    await db.execute(
        'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
});

print('DB created');
}