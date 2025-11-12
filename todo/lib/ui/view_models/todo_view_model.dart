import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/domain/todo_domain.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/core/config.dart';

class TodoViewModel extends ChangeNotifier {
  //
  bool _isLoading = false;

  static TodoViewModel get instance => GetIt.instance<TodoViewModel>();

  List<Todo> get todos => TodoDomain.todos;
  bool get isLoading => _isLoading;
  DataSources get dataSource => TodoDomain.dataSource;

  Future<void> setDataSource(DataSources ds) async {
    _isLoading = true;
    notifyListeners();
    try {
      await TodoDomain.setDataSource(ds);
      //do not auto reload; await fetchAll();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void onCheckItem(Todo item) {
    item.isDone = !item.isDone;
    notifyListeners();
  }

  void onItemTitleChange(Todo item, String text) {
    item.title = text;
    notifyListeners();
  }

  Future<List<Todo>> fetchAll() async {
    try {
      return await TodoDomain.fetch();
    } finally {}
  }

  Future<String> checkAndSaveItem(int index) async {
    //_isLoading = true;    notifyListeners();    try {
    todos[index].isDone = !todos[index].isDone;
    String error = await saveItem(index, todos[index]);
    notifyListeners();

    //if failed, restore state
    if (error.isNotEmpty) {
      todos[index].isDone = !todos[index].isDone;
      notifyListeners();
    }
    return error;
    //} finally {      _isLoading = false;      notifyListeners();    }
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

  Todo copyOrCreate(int index) {
    Todo todo = (index >= 0 ? Todo.copy(todos[index]) : Todo());
    if (todo.title.isEmpty) {
      todo.title = 'Todo';
    }
    return todo;
  }
}
