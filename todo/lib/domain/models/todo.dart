import 'dart:convert';

class Todo {
  int id;
  String title;
  bool isDone;
  int userId;

  Todo({this.id = 0, this.title = '', this.isDone = false, this.userId = 0});

  factory Todo.copy(Todo todo) {
    return Todo(
      id: todo.id,
      title: todo.title,
      isDone: todo.isDone,
      userId: todo.userId,
    );
  }

  factory Todo.fromMap(Map<String, dynamic> json) => Todo(
    id: json['id'],
    title: json['todo'],
    isDone: (json['completed'] == 'true' || json['completed'] == 1),
    userId: json['userId'],
  );

  Map<String, dynamic> toMap([bool db = true]) {
    final trueVal = db ? '1' : 'true';
    final falseVal = db ? '0' : 'false';
    return id > 0
        ? {
            'id': id.toString(),
            'todo': title,
            'completed': isDone ? trueVal : falseVal,
            'userId': userId.toString(),
          }
        : {
            'todo': title,
            'completed': isDone ? trueVal : falseVal,
            'userId': userId.toString(),
          };
  }

  String toJson([bool db = false]) {
    final trueVal = db ? '1' : 'true';
    final falseVal = db ? '0' : 'false';
    return jsonEncode(<String, String>{
      'id': (id > 0 ? id.toString() : ''),
      'todo': title,
      'completed': isDone ? trueVal : falseVal,
      'userId': userId.toString(),
    });
  }

  factory Todo.fromJson(Map<String, dynamic> json, [bool db = false]) {
    //Api list vs item, and Api vs Db are NOT consistent!!!
    Todo todo = db
        ? Todo(
            id: json['id'],
            title: json['todo'],
            isDone: (json['completed'] == 'true' || json['completed'] == 1),
            userId: int.tryParse(json['userId']) ?? 0,
          )
        : Todo(
            id: json['id'],
            title: json['todo'],
            isDone: json['completed'],
            userId: json['userId'],
          );
    return todo;
  }

  static List<Todo> fromJsonList(Map<String, dynamic> json) {
    final todosJson = json['todos'] as List<dynamic>;
    final todos = todosJson.map((e) => Todo.fromJson(e, false)).toList();
    return todos;
  }
}
