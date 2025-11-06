import 'package:todo/domain/models/todo.dart';

abstract class ITodoRepository {
  //

  Future<List<Todo>> fetch();

  Future<void> save(Todo todo);

  Future<void> remove(int id);
}

class TodoRepositoryDummy implements ITodoRepository {
  //

  @override
  Future<List<Todo>> fetch() async {
    return [];
  }

  @override
  Future<void> save(Todo todo) async {}

  @override
  Future<void> remove(int id) async {}
}
