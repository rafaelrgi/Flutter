import 'package:flutter/material.dart';

class CounterModel extends ChangeNotifier {
  int _count = 0;

  int getCount() => _count;
  void increment() {
    ++_count;
    notifyListeners();
  }

  void reset() {
    _count = 0;
    notifyListeners();
  }

  String getMessage() {
    if (_count % 3 == 0) {
      return 'Parabéns, você clicou $_count vezes!!!';
    } else if (_count % 5 == 0) {
      return 'Chega, assim vai quebrar o contador!!!!!';
    }
    return '';
  }
}
