import 'package:flutter/material.dart';

//Singleton para facilitar; UNDONE: implementar injeção de dependência depois
CounterViewModel counterViewModel = CounterViewModel();

class CounterViewModel extends ChangeNotifier {
  int _count = 0;

  int get count => _count;
  bool get canDecrement => _count > 0;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    if (!canDecrement) return;

    _count--;
    notifyListeners();
  }

  Color getLabelColor() {
    if (_count >= 6) {
      return Colors.red;
    }
    if (_count < 3) {
      return Colors.green;
    }
    return Colors.amber;
  }
}
