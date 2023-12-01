import 'package:counter_provider/counter/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterValue extends StatelessWidget {
  const CounterValue({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterModel(),
      child: const Text('0'),
    );
  }
}
