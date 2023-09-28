import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'counter/model.dart';
import 'utils/toast.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterModel(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterModel>(context, listen: false);

    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple),
      scaffoldMessengerKey: Toast.key,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Contador Com Provider'), actions: [
          IconButton(
              tooltip: 'Zerar o contador',
              icon: const Icon(Icons.restart_alt, color: Colors.white, size: 34.0),
              onPressed: () => counter.reset()),
        ]),
        body: Center(
          child: Consumer<CounterModel>(builder: (context, data, child) {
            return Text(
              "${data.getCount()}",
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: Theme.of(context).textTheme.displayMedium?.fontSize),
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Incrementar o contador',
          onPressed: () {
            counter.increment();
            String msg = counter.getMessage();
            if (msg.isNotEmpty) Toast.show(msg);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
