import 'package:flutter/material.dart';
import 'package:imc/imc/model.dart';
import 'package:provider/provider.dart';

class BotaoCalcular extends StatelessWidget {
  const BotaoCalcular({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Consumer<Imc>(builder: (ctx, imc, child) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(40), // NEW
        ),
        onPressed: !imc.canCalcular() ? null : onPressed,
        child: const Text('Calcular'),
      );
    });
  }
}
