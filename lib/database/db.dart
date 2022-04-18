import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//Global variables
var noteList = [];
var noteEdit = [];
//Nova baza podataka
Future createdatabase() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'suaz.db');
  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, date TEXT)');
    await db.execute(
        'CREATE TABLE Done (id INTEGER PRIMARY KEY, name TEXT, date TEXT, dateDone TEXT)');
  });
}

//Prikazi taskove
Future<List> selector() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'suaz.db');
  Database database = await openDatabase(path);
  List<Map> list = await database.rawQuery('SELECT * FROM Test ORDER BY name');
  noteList = list;
  return noteList;
}

Future<List> selectorbyDate() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'suaz.db');
  Database database = await openDatabase(path);
  List<Map> list =
      await database.rawQuery('SELECT * FROM Test ORDER BY date desc');
  noteList = list;
  return noteList;
}

//Ubaci novi task
Future noteInsertor({required String name, required String date}) async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'suaz.db');
  Database database = await openDatabase(path);
  await database
      .rawInsert('INSERT INTO Test(name, date) VALUES("$name", "$date")');
}

//Uredi task
//Kako treba sakrivat argumente protiv sql injekcija, ovdje je prava verzija ostale su normala
Future noteEditor(
    {required int index, required String name, required String date}) async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'suaz.db');
  Database database = await openDatabase(path);
  await database.rawUpdate('''UPDATE Test 
      SET name = ?, date = ?
      WHERE id = ?
      ''', ["$name", "$date", index]);
}

//Izbrisi task
Future noteDelete({
  required int index,
}) async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'suaz.db');
  Database database = await openDatabase(path);
  await database.rawDelete('DELETE FROM Test WHERE id = ?', [index]);
}

//Selektuj po idu
Future<List> selectorbyId({required int index}) async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'suaz.db');
  Database database = await openDatabase(path);
  List<Map> list =
      await database.rawQuery('SELECT * FROM Test WHERE id LIKE $index');
  noteEdit = list;
  print(noteEdit);
  return noteEdit;
}

//Done

Future<List> selectorDone() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'suaz.db');
  Database database = await openDatabase(path);
  List<Map> list = await database.rawQuery('SELECT * FROM Done ORDER BY date');
  noteList = list;
  return noteList;
}

Future noteDoneInsertor(
    {required String name,
    required String date,
    required String dateDone}) async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'suaz.db');
  Database database = await openDatabase(path);
  await database.rawInsert(
      'INSERT INTO Done(name, date, dateDone) VALUES("$name", "$date", "$dateDone")');
}

Future noteDoneDelete({
  required int index,
}) async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'suaz.db');
  Database database = await openDatabase(path);
  await database.rawDelete('DELETE FROM Done WHERE id = ?', [index]);
}
