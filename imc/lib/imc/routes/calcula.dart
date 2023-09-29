import 'package:flutter/material.dart';
import 'package:imc/imc/routes/resultado.dart';
import 'package:imc/imc/widgets/botao.dart';
import 'package:imc/imc/widgets/text.dart';

class Calcula extends StatelessWidget {
  const Calcula({super.key});

  void calcula(BuildContext ctx) {
    Navigator.push(ctx, MaterialPageRoute(builder: (ctx) => const Resultado()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora IMC')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 64),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Flexible(
                  child: TextAltura(),
                ),
                Text('m',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                    )),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Flexible(
                  child: TextPeso(),
                ),
                Text('kg',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                    )),
              ],
            ),
            const SizedBox(height: 28),
            BotaoCalcular(onPressed: () => calcula(context)),
          ],
        ),
      ),
    );
  }
}
