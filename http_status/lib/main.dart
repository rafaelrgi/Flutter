import 'package:flutter/material.dart';
import 'package:http_status/http_status/routes/lista.dart';
import 'package:provider/provider.dart';

import 'http_status/model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => HttpStatus(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.yellow),
      debugShowCheckedModeBanner: false,
      home: const Lista(),
    );
  }
}
