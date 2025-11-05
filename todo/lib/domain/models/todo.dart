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

  factory Todo.fromJson(Map<String, dynamic> json, [bool list = false]) {
    //list and item are NOT consistent!!!
    Todo todo = list
        ? Todo(
            id: json['id'],
            title: json['todo'],
            isDone: json['completed'],
            userId: json['userId'],
          )
        : Todo(
            id: json['id'],
            title: json['todo'],
            isDone: (json['completed'] == 'true'),
            userId: int.tryParse(json['userId']) ?? 0,
          );

    return todo;
  }

  static List<Todo> fromJsonList(Map<String, dynamic> json) {
    final todosJson = json['todos'] as List<dynamic>;
    final todos = todosJson.map((e) => Todo.fromJson(e, true)).toList();
    return todos;
  }
}
