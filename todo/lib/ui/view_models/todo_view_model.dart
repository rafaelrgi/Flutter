import 'package:flutter/material.dart';
import 'package:todo/domain/todo_domain.dart';
import 'package:todo/domain/models/todo.dart';

//Singleton para facilitar; UNDONE: implementar injeção de dependência
final todoViewModel = TodoViewModel();

class TodoViewModel extends ChangeNotifier {
  //
  bool _isLoading = false;

  List<Todo> get todos => TodoDomain.todos;
  bool get isLoading => _isLoading;

  Future<String> onItemTap(int index) async {
    todos[index].isDone = !todos[index].isDone;
    String error = await saveItem(index, todos[index]);
    //if failed, restore state
    if (error.isNotEmpty) {
      todos[index].isDone = !todos[index].isDone;
      notifyListeners();
    }
    return error;
  }

  Future<List<Todo>> fetchList() async {
    try {
      return await TodoDomain.fetch();
    } finally {}
  }

  void checkItem(Todo item) {
    item.isDone = !item.isDone;
    notifyListeners();
  }

  void textItem(Todo item, String text) {
    item.title = text;
    notifyListeners();
  }

  Future<String> removeItem(int index) async {
    try {
      _isLoading = true;
      notifyListeners();
      await TodoDomain.remove(todos[index].id);
      todos.removeAt(index);
    } catch (e) {
      return e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return '';
  }

  Future<String> saveItem(int index, Todo todo) async {
    try {
      _isLoading = true;
      notifyListeners();
      await TodoDomain.save(todo);
      //new item?
      if (index < 0) {
        todos.insert(0, todo);
      } else {
        todos[index] = todo;
      }
    } catch (e) {
      return e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return '';
  }
}
