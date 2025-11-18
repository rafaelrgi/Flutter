import 'package:counter_bloc/blocs/counter_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  //
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter Bloc')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            BlocBuilder<CounterCubit, int>(
              builder: (context, count) => Center(
                child: Text(
                  '$count',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: context.read<CounterCubit>().getLabelColor(),
                  ),
                ),
              ),
            ),
            BlocBuilder<CounterCubit, int>(
              builder: (context, count) => Center(
                child: count > 9
                    ? Text(
                        'Stop, you\'re gonna break it!!!!',
                        style: Theme.of(context).textTheme.headlineSmall,
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => context.read<CounterCubit>().increment(),
          ),
          const SizedBox(height: 4),
          BlocBuilder<CounterCubit, int>(
            builder: (context, count) =>
                context.read<CounterCubit>().canDecrement
                ? FloatingActionButton(
                    child: const Icon(Icons.remove),
                    onPressed: () => context.read<CounterCubit>().decrement(),
                  )
                : const FloatingActionButton(
                    onPressed: null,
                    foregroundColor: Colors.black38,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.remove),
                  ),
          ),
        ],
      ),
    );
  }
}
