import 'package:flutter/material.dart';
import 'package:imc/imc/routes/calcula.dart';
import 'package:provider/provider.dart';

import 'imc/model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Imc(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      home: const Calcula(),
    );
  }
}
