import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';

import '../models/note.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  NotesDatabase._init();

  static sqflite.Database? _database;

  static final String tableName = 'notes';
  static final String tablePath = 'notes.db';
  static final int tableVersion = 1;
  static final String colId = 'id';
  static final String colTitle = 'title';
  static final String colDescription = 'description';
  static final String colDate = 'date';
  static final String colColor = 'color_index';

  Future<sqflite.Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(tablePath);
    return _database!;
  }

  Future<sqflite.Database> _initDB(String filePath) async {
    final dbPath = await sqflite.getDatabasesPath();
    final path = join(dbPath, filePath);
    return await sqflite.openDatabase(
      path,
      version: tableVersion,
      onCreate: _createDB,
      // onUpgrade: (db, oldVersion, newVersion) {
      //   if (oldVersion < 2) {
      //     db.execute(
      //       'ALTER TABLE $tableName ADD COLUMN $colColor INTEGER NOT NULL',
      //     );
      //   }
      // },
    );
  }

  Future _createDB(sqflite.Database db, int version) async {
    await db.execute('''CREATE TABLE $tableName(
        $colId INTEGER PRIMARY KEY AUTOINCREMENT, 
        $colTitle TEXT NOT NULL, 
        $colDescription TEXT NOT NULL, 
        $colDate TEXT NOT NULL, 
        $colColor INTEGER NOT NULL
      )''');
  }

  Future<int> addNote(Note note) async {
    final db = await instance.database;
    final id = await db.insert(tableName, {
      colTitle: note.title,
      colDescription: note.description,
      colDate: note.date,
      colColor: note.colorIndex,
    });
    //print('Note Saved with ID: $id');
    return id;
  }

  Future<List<Note>> getNotes() async {
    final db = await instance.database;
    final result = await db.query(tableName, orderBy: "$colDate DESC");
    return result.map((note) => Note.fromMap(note)).toList();
  }

  Future<int> updateNote(Note note) async {
    final db = await instance.database;
    final id = await db.update(
      tableName,
      {
        colTitle: note.title,
        colDescription: note.description,
        colDate: note.date,
        colColor: note.colorIndex,
      },
      where: '$colId = ?',
      whereArgs: [note.id],
    );
    //print('Note Updated with ID: $id');
    return id;
  }

  Future<int> deleteNote(int id) async {
    final db = await instance.database;
    return await db.delete(tableName, where: '$colId = ?', whereArgs: [id]);
  }
}
