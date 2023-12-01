import 'package:flutter/material.dart';
import 'package:imc/imc/model.dart';
import 'package:imc/imc/widgets/tabela.dart';
import 'package:provider/provider.dart';

class Resultado extends StatelessWidget {
  const Resultado({super.key});

  @override
  Widget build(BuildContext context) {
    final imc = Provider.of<Imc>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora IMC - Resultado')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Center(
              child: Text(
                'IMC: ${imc.getImc()}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Center(
              child: Text(
                imc.getImcDescricao(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 64),
            TabelaOms(),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 48),
                child: Text('Voltar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
