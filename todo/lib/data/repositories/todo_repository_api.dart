import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo/data/repositories/i_todo_repository.dart';
import 'package:todo/domain/models/todo.dart';

class TodoRepositoryApi implements ITodoRepository {
  //
  static const String _url = 'https://dummyjson.com/todos';
  static const Map<String, String> _headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  @override
  Future<List<Todo>> fetch() async {
    final String data = await _fetchFromApi();
    final todos = Todo.fromJsonList(json.decode(data));
    return todos;
  }

  @override
  Future<void> save(Todo todo) async {
    todo.userId = 1;
    Todo saved = await ((todo.id <= 0) ? _post(todo) : _put(todo));
    todo.id = saved.id;
    //simulate error: throw 'Deu ruim!!!!!!';
  }

  @override
  Future<void> remove(int id) async {
    await _remove(id);
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
