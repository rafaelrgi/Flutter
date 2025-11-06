import 'package:todo/core/config.dart';
import 'package:todo/data/repositories/i_todo_repository.dart';
import 'package:todo/data/repositories/todo_repository_Api.dart';
import 'package:todo/data/repositories/todo_repository_db.dart';
import 'package:todo/data/repositories/todo_repository_memory.dart';
import 'package:todo/domain/models/todo.dart';

class TodoDomain {
  static final List<Todo> _todos = [];
  static ITodoRepository _todoRepos = TodoRepositoryDummy();
  static DataSources _dataSource = DataSources.none;

  static List<Todo> get todos => _todos;
  static DataSources get dataSource => _dataSource;

  static Future<void> setDataSource(DataSources ds) async {
    await Config.setDataSource(ds);
    _dataSource = ds;
    _createRpository();
  }

  static Future<List<Todo>> fetch() async {
    if (_dataSource == DataSources.none) {
      _dataSource = await Config.getDataSource();
      _createRpository();
    }

    _todos.clear();
    _todos.addAll(await _todoRepos.fetch());
    return _todos;
  }

  static Future<void> save(Todo todo) async {
    await _todoRepos.save(todo);
  }

  static Future<void> remove(int id) async {
    await _todoRepos.remove(id);
  }

  static void _createRpository() {
    switch (_dataSource) {
      case DataSources.memory:
        _todoRepos = TodoRepositoryMemory();
        break;
      case DataSources.remoteApi:
        _todoRepos = TodoRepositoryApi();
        break;
      case DataSources.localDb:
        _todoRepos = TodoRepositoryDb();
        break;
      case DataSources.none:
        _todoRepos = TodoRepositoryDummy();
        break;
    }
  }
}
