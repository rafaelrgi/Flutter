import 'package:flutter/material.dart';
import 'package:http_status/http_status/model.dart';
import 'package:http_status/http_status/widgets/lista_status.dart';
import 'package:provider/provider.dart';

import 'detalhe.dart';

class Lista extends StatelessWidget {
  const Lista({super.key});

  void random(BuildContext context) {
    final httpStatus = Provider.of<HttpStatus>(context, listen: false);
    int codigo = httpStatus.getRandomCode();
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => Detalhe(codigo: codigo)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HTTP Status'), actions: [
        IconButton(
            tooltip: 'Aleatório',
            icon: const Icon(Icons.auto_fix_high,
                color: Colors.black87, size: 32.0),
            onPressed: () => random(context)),
      ]),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListaStatus(),
      ),
    );
  }
}
