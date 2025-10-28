import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  bool get canDecrement => state > 0;
  void increment() => emit(state + 1);
  void decrement() => canDecrement ? emit(state - 1) : null;

  Color getLabelColor() {
    if (state > 5 || state < 0) {
      return Colors.red;
    }
    if (state < 3) {
      return Colors.green;
    }
    return Colors.amber;
  }
}
