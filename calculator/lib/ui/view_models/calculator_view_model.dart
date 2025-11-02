import 'package:calculator/core/str_utils.dart';
import 'package:flutter/material.dart';

//Singleton para facilitar; UNDONE: implementar injeção de dependência depois
CalculatorViewModel calculatorViewModel = CalculatorViewModel();

enum _Operations { none, add, subtract, multiply, divide }

class CalculatorViewModel extends ChangeNotifier {
  //

  double _value = 0;
  String _display = '0';
  bool _insertMode = false;
  _Operations _operation = _Operations.none;

  String get display => _display;
  String get value => _value == 0 ? '' : _value.asString(true);
  String get operation => _getOperation();

  void button(String button) {
    switch (button) {
      case 'C':
        _buttonClear();
        break;
      case 'CE':
        _buttonClearEntry();
        break;
      case '.':
        _buttonDecimal();
        break;
      case '±':
        _buttonPlusMinus();
        break;
      case '+':
        _buttonPlus();
        break;
      case '-':
        _buttonMinus();
        break;
      case '÷':
        _buttonDivide();
        break;
      case 'x':
        _buttonMultiply();
        break;
      case '=':
        _buttonTotal();
        break;
      //number
      default:
        _display = (_insertMode || _display == '0')
            ? button
            : _display + button;
        _insertMode = false;
    }
    notifyListeners();
  }

  void _buttonClear() {
    _value = 0;
    _display = '0';
    _operation = _Operations.none;
  }

  void _buttonClearEntry() {
    _display = '0';
  }

  void _buttonDecimal() {
    if (_insertMode) {
      if (_value == 0) {
        _value = _getValueFromDisplay();
      }
      _display = '0,';
      _insertMode = false;
      return;
    }
    if (_display.contains(',')) return;
    _display += ',';
  }

  void _buttonPlusMinus() {
    if (_display.startsWith('-')) {
      _display = _display.substring(1);
    } else {
      _display = '-$_display';
    }
  }

  void _buttonPlus() {
    _applyPreviousOperation();
    _operation = _Operations.add;
  }

  void _buttonMinus() {
    _applyPreviousOperation();
    _operation = _Operations.subtract;
  }

  void _buttonMultiply() {
    _applyPreviousOperation();
    _operation = _Operations.multiply;
  }

  void _buttonDivide() {
    _applyPreviousOperation();
    _operation = _Operations.divide;
  }

  void _buttonTotal() {
    _applyPreviousOperation();
    _display = _value.asString(true);
    _value = 0;
    _operation = _Operations.none;
  }

  double _getValueFromDisplay() {
    if (!_display.contains(',')) {
      return double.tryParse(_display) ?? 0;
    }
    return double.tryParse(_display.replaceAll('.', '').replaceAll(',', '.')) ??
        0;
  }

  String _getOperation() {
    switch (_operation) {
      case _Operations.add:
        return '+';
      case _Operations.subtract:
        return '-';
      case _Operations.multiply:
        return 'x';
      case _Operations.divide:
        return '÷';
      case _Operations.none:
        return '';
    }
  }

  void _applyPreviousOperation() {
    if (_insertMode) {
      if (_value == 0) {
        _value = _getValueFromDisplay();
      }
      return;
    }
    var x = _getValueFromDisplay();
    switch (_operation) {
      case _Operations.add:
        _value += x;
        break;
      case _Operations.subtract:
        _value -= x;
        break;
      case _Operations.multiply:
        _value *= x;
        break;
      case _Operations.divide:
        if (x != 0) {
          _value /= x;
        }
        break;
      case _Operations.none:
        _value = x;
        break;
    }
    _display = _value.asString(true);
    _insertMode = true;
  }
}
