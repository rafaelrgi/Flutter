import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:todo/domain/models/todo.dart';

class TodoRepository {
  //
  static const bool _memory = false;
  static const String _url = 'https://dummyjson.com/todos';
  static const Map<String, String> _headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Future<List<Todo>> fetch() async {
    final String data = await (_memory ? _fetchFromMem() : _fetchFromApi());
    final todos = Todo.fromJsonList(json.decode(data));
    return todos;
  }

  Future<void> save(Todo todo) async {
    todo.userId = 1;

    if (_memory) {
      await Future.delayed(const Duration(seconds: 1));
      if (todo.id <= 0) todo.id = Random().nextInt(4096) + 666;
      return;
    }

    Todo saved = await ((todo.id <= 0) ? _post(todo) : _put(todo));
    todo.id = saved.id;
    //simulate error: throw 'Deu ruim!!!!!!';
  }

  Future<void> remove(int id) async {
    if (_memory) {
      Future.delayed(const Duration(seconds: 1));
      return;
    }
    await _remove(id);
  }

  Future<String> _fetchFromMem() async {
    await Future.delayed(const Duration(seconds: 1));
    return __json;
  }

  Future<String> _fetchFromApi() async {
    final uri = Uri.parse(_url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  String _encode(Todo todo) {
    final id = todo.id > 0 ? todo.id.toString() : '';
    return jsonEncode(<String, String>{
      'id': id,
      'todo': todo.title,
      'completed': todo.isDone ? 'true' : 'false',
      'userId': todo.userId.toString(),
    });
  }

  Future<Todo> _post(Todo todo) async {
    final response = await http.post(
      Uri.parse('$_url/add'),
      headers: _headers,
      body: _encode(todo),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Todo.fromJson(json.decode(response.body));
    } else {
      throw 'Saving failed: ${response.statusCode}';
    }
  }

  Future<Todo> _put(Todo todo) async {
    final response = await http.put(
      Uri.parse('$_url/${todo.id}'),
      headers: _headers,
      body: _encode(todo),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Todo.fromJson(json.decode(response.body));
    } else {
      throw 'Saving failed: ${response.statusCode}';
    }
  }

  Future<void> _remove(int id) async {
    final response = await http.delete(
      Uri.parse('$_url/$id'),
      headers: _headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return;
    } else {
      throw 'Deletion failed: ${response.statusCode}';
    }
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
