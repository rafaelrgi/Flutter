import 'package:flutter/material.dart';
import 'package:http_status/http_status/model.dart';
import 'package:provider/provider.dart';

import '../widgets/detalhe_status.dart';

class Detalhe extends StatelessWidget {
  const Detalhe({super.key, required this.codigo});

  final int codigo;

  @override
  Widget build(BuildContext context) {
    final httpStatus = Provider.of<HttpStatus>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text('HTTP Status - $codigo')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: DetalheStatus(codigo: codigo, httpStatus: httpStatus),
      ),
    );
  }
}
