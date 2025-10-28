import 'package:counter_mvvm/view_models/counter_view_model.dart';
import 'package:flutter/material.dart';

class CounterView extends StatelessWidget {
  //

  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter MVVM')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            ListenableBuilder(
              listenable: counterViewModel,
              builder: (context, child) {
                return Column(
                  children: [
                    Text(
                      '${counterViewModel.count}',
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(color: counterViewModel.getLabelColor()),
                    ),
                    counterViewModel.count > 9
                        ? Text(
                            'Stop, you\'re gonna break it!!!!',
                            style: Theme.of(context).textTheme.headlineSmall,
                          )
                        : const SizedBox.shrink(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () => counterViewModel.increment(),
            tooltip: 'Increment the counter',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 4),
          ListenableBuilder(
            listenable: counterViewModel,
            builder: (context, child) {
              return counterViewModel.canDecrement
                  ? FloatingActionButton(
                      onPressed: counterViewModel.decrement,
                      tooltip: 'Decrement the counter',
                      child: const Icon(Icons.remove),
                    )
                  : const FloatingActionButton(
                      onPressed: null,
                      foregroundColor: Colors.black38,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.remove),
                    );
            },
          ),
        ],
      ),
    );
  }
}
