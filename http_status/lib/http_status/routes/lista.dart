import 'package:flutter/material.dart';
import 'package:http_status/http_status/widgets/lista_status.dart';

class Lista extends StatelessWidget {
  const Lista({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HTTP Status')),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListaStatus(),
      ),
    );
  }
}
