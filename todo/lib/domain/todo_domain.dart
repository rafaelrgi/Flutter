import 'package:todo/domain/models/todo.dart';
import 'package:todo/data/repositories/todo_repository.dart';

class TodoDomain {
  static List<Todo> _todos = [];
  static final TodoRepository todoRepos = TodoRepository();

  static List<Todo> get todos => _todos;

  static Future<void> fetch() async {
    _todos = [];
    _todos = await todoRepos.fetch();
  }

  static Future<void> save(Todo todo) async {
    await todoRepos.save(todo);
  }

  static Future<void> remove(int id) async {
    await todoRepos.remove(id);
  }
}
