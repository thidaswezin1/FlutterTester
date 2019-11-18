import 'package:myfirstflutterapp/model/Notes.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper{
  static Database _db;
  Future<Database> get db async{
    if(_db!=null) return _db;
    _db = await initDb();
    return _db;
  }
  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "test.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }
  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE Notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, note TEXT )");
    print("Created tables");
  }
  void saveNotes(Notes notes) async{
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO Notes(title, note) VALUES('+ '\'' + notes.title + '\'' + ',' + '\'' + notes.note +  '\'' +')'
      );
    });

  }
  Future<List<Notes>> getNotes() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Notes');
    List<Notes> notes = new List();
    for (int i = 0; i < list.length; i++) {
      notes.add(new Notes( list[i]["title"], list[i]["note"]));
    }
    print(notes.length);
    return notes;
  }
}