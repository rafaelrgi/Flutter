import 'package:flutter/material.dart';
import 'package:http_status/http_status/model.dart';
import 'package:provider/provider.dart';

import '../routes/detalhe.dart';

class ListaStatus extends StatelessWidget {
  const ListaStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HttpStatus>(builder: (ctx, http, child) {
      return _lista(context, http);
    });
  }

  ListView _lista(BuildContext context, HttpStatus http) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: http.getCount(),
      itemBuilder: (BuildContext context, int index) {
        String title = http.getCode(index);
        bool isNumeric = (int.tryParse(title) ?? 0) != 0;

        return ListTile(
            title: Text(title,
                style: isNumeric
                    ? null
                    : TextStyle(color: Theme.of(context).textTheme.displayLarge?.color)),
            leading:
                !isNumeric ? null : Icon(Icons.http, color: Theme.of(context).primaryColorDark),
            onTap: !isNumeric
                ? null
                : () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => Detalhe(codigo: (int.tryParse(title)) ?? 0)));
                  });
      },
    );
  }
}
