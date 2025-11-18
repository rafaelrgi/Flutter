import 'package:get_it/get_it.dart';
import 'package:todo/core/app.dart';
import 'package:flutter/material.dart';
import 'package:todo/ui/view_models/login_view_model.dart';
import 'package:todo/ui/view_models/todo_view_model.dart';

//------------------------------------------------------------------------------
void _configureDependencies() {
  final getIt = GetIt.instance;
  getIt.registerCachedFactory(() => LoginViewModel());
  getIt.registerLazySingleton<TodoViewModel>(() => TodoViewModel());
}
//------------------------------------------------------------------------------

void main() {
  _configureDependencies();
  runApp(TodoApp());
}
