import 'package:calculator/ui/view_models/calculator_view_model.dart';
import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  //
  final String label;
  final Color color;

  const CalculatorButton(this.label, {this.color = Colors.white, super.key});

  @override
  Widget build(BuildContext context) {
    return label.isEmpty
        ? const SizedBox.shrink()
        : InkWell(
            onTap: () => calculatorViewModel.button(label),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(color: color),
              ),
            ),
          );
  }
}
