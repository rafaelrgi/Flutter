import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imc/imc/model.dart';
import 'package:provider/provider.dart';

class TextAltura extends StatelessWidget {
  const TextAltura({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Imc>(builder: (ctx, imc, child) {
      return TextField(
        textInputAction: TextInputAction.next,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
        ],
        decoration: InputDecoration(
          labelText: 'Altura',
          hintText: "Altura em metros, ex.: 1,60",
          errorText: imc.getErroAltura(),
        ),
        onChanged: (String s) => imc.setAltura(s),
      );
    });
  }
}

class TextPeso extends StatelessWidget {
  const TextPeso({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Imc>(builder: (ctx, imc, child) {
      return TextField(
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(decimal: true, signed: imc.canCalcular()),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
        ], //
        decoration: InputDecoration(
          labelText: 'Peso',
          hintText: 'Peso em quilos, ex.: 70',
          errorText: imc.getErroPeso(),
        ),
        onChanged: (String s) => imc.setPeso(s),
      );
    });
  }
}
