import 'package:calculator/ui/view_models/calculator_view_model.dart';
import 'package:calculator/ui/widgets/calculator_button.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  //

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: ListenableBuilder(
                listenable: calculatorViewModel,
                builder: (context, child) {
                  return Text(
                    calculatorViewModel.display,
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.headlineLarge,
                    overflow: TextOverflow.ellipsis,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                childAspectRatio: 1.1,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                CalculatorButton(''), //???
                CalculatorButton('C', color: Colors.red),
                CalculatorButton('CE', color: Colors.red),
                CalculatorButton('÷', color: Colors.yellow),

                CalculatorButton('7'),
                CalculatorButton('8'),
                CalculatorButton('9'),
                CalculatorButton('x', color: Colors.yellow),

                CalculatorButton('4'),
                CalculatorButton('5'),
                CalculatorButton('6'),
                CalculatorButton('-', color: Colors.yellow),

                CalculatorButton('1'),
                CalculatorButton('2'),
                CalculatorButton('3'),
                CalculatorButton('+', color: Colors.yellow),

                CalculatorButton('±', color: Colors.yellow),
                CalculatorButton('0'),
                CalculatorButton('.', color: Colors.orange),
                CalculatorButton('=', color: Colors.greenAccent),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
