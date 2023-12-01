import 'package:flutter/material.dart';
import 'package:imc/imc/model.dart';
import 'package:provider/provider.dart';

class TabelaOms extends StatelessWidget {
  TabelaOms({super.key});

  final List<TableRow> rows = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<Imc>(builder: (ctx, imc, child) {
      var tbl = imc.getTabelaOms();
      rows.add(TableRow(children: [
        Container(alignment: Alignment.center, child: const Text('IMC')),
        Container(alignment: Alignment.center, child: const Text('Classificação OMS')),
      ]));
      for (var i = 0; i < tbl.length; i++) {
        rows.add(TableRow(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 16, 4),
            child: Text(tbl[i][0],
                style: i != imc.getFaixa()
                    ? null
                    : TextStyle(color: Theme.of(context).primaryColorDark)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 22, 4),
            child: Text(tbl[i][1],
                style: i != imc.getFaixa()
                    ? null
                    : TextStyle(color: Theme.of(context).primaryColorDark)),
          ),
        ]));
      }

      return Table(
          columnWidths: const <int, TableColumnWidth>{
            0: IntrinsicColumnWidth(),
            1: IntrinsicColumnWidth(),
          },
          border: TableBorder.all(color: Colors.black26, style: BorderStyle.solid, width: 1.0),
          children: rows);
    });
  }
}
