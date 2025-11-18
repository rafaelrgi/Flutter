import 'package:todo/core/db.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/data/repositories/i_todo_repository.dart';

class TodoRepositoryDb implements ITodoRepository {
  //
  @override
  Future<List<Todo>> fetch() async {
    final db = await DB.database;
    var rows = await db.query(DB.todosTable);
    final List<Todo> todos = rows.isNotEmpty
        ? rows.map((c) => Todo.fromMap(c)).toList()
        : [];
    return todos;
  }

  @override
  Future<void> save(Todo todo) async {
    Todo saved = await ((todo.id <= 0) ? _insert(todo) : _update(todo));
    todo.id = saved.id;
    //simulate error: throw 'Deu ruim!!!!!!';
  }

  @override
  Future<void> remove(int id) async {
    await _remove(id);
  }

  Future<Todo> _insert(Todo todo) async {
    final db = await DB.database;
    todo.id = await db.insert(DB.todosTable, todo.toMap());
    return todo;
  }

  Future<Todo> _update(Todo todo) async {
    final db = await DB.database;
    todo.id = await db.update(
      DB.todosTable,
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
    return todo;
  }

  Future<void> _remove(int id) async {
    final db = await DB.database;
    db.delete(DB.todosTable, where: 'id = ?', whereArgs: [id]);
  }
}
