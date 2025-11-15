import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//Singleton static class
class DB {
  //
  static Database? _database;
  static final DB instance = DB._();
  static const todosTable = 'Todos';

  DB._();

  static Future<Database> get database async {
    return _database ?? await _initDatabase();
  }

  static Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'todo.db');
    //await deleteDatabase(path); //await File(path).delete();

    _database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return _database!;
  }

  static void _onCreate(Database db, int version) async {
    await db.execute(createTodo);
  }

  static const String createTodo =
      '''
    Create Table $todosTable (
      id Integer Primary Key AutoIncrement,
      todo Text,
      completed Integer,
      userId Integer
    );
  ''';
}
