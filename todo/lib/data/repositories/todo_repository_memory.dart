import 'dart:convert';
import 'dart:isolate';
import 'dart:math';
import 'package:todo/data/repositories/i_todo_repository.dart';
import 'package:todo/domain/models/todo.dart';

class TodoRepositoryMemory implements ITodoRepository {
  //

  @override
  Future<List<Todo>> fetch() async {
    //do the work in another thread
    return Isolate.run(() async {
      final todos = Todo.fromJsonList(json.decode(__json));
      //simulate a huge workload causing a huge delay
      // await Future.delayed(const Duration(seconds: 1));
      // for (var i = 0; i < 10000; i++) print(i);
      return todos;
    });
  }

  @override
  Future<void> save(Todo todo) async {
    todo.userId = 1;
    await Future.delayed(const Duration(seconds: 1));
    if (todo.id <= 0) todo.id = Random().nextInt(4096) + 666;
    return;
    //simulate error: throw 'Deu ruim!!!!!!';
  }

  @override
  Future<void> remove(int id) async {
    Future.delayed(const Duration(seconds: 1));
  }
}

const __json = '''
{
  "todos": [
    {
      "id": 1,
      "todo": "Do something nice for someone I care about",
      "completed": true,
      "userId": 1
    },
    {
      "id": 2,
      "todo": "Walk the dog",
      "completed": false,
      "userId": 1
    },
    {
      "id": 3,
      "todo": "Feed the cat",
      "completed": false,
      "userId": 1
    },
    {
      "id": 4,
      "todo": "Pet the cat",
      "completed": false,
      "userId": 1
    },
    {
      "id": 5,
      "todo": "Buy groceries",
      "completed": false,
      "userId": 1
    },
    {
      "id": 6,
      "todo": "Workout 6",
      "completed": false,
      "userId": 1
    },
    {
      "id": 7,
      "todo": "Do nothing 7",
      "completed": false,
      "userId": 1
    },
    {
      "id": 8,
      "todo": "Get some rest 8",
      "completed": false,
      "userId": 1
    },
    {
      "id": 9,
      "todo": "Do something 9",
      "completed": false,
      "userId": 1
    },
    {
      "id": 10,
      "todo": "Blah blah blah 10",
      "completed": false,
      "userId": 1
    },
    {
      "id": 11,
      "todo": "Lorem ipsum 11",
      "completed": false,
      "userId": 1
    }
  ],
  "total": 2,
  "skip": 0,
  "limit": 666
}
''';
