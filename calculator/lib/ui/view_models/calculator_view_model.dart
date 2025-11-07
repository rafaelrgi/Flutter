import 'package:calculator/core/str_utils.dart';
import 'package:flutter/material.dart';

//Singleton para facilitar; UNDONE: implementar injeção de dependência
CalculatorViewModel calculatorViewModel = CalculatorViewModel();

enum _Operations { none, add, subtract, multiply, divide }

class CalculatorViewModel extends ChangeNotifier {
  //

  String _display = '0';
  double _op1 = 0;
  _Operations _operator = _Operations.none;
  bool _insertMode = false;

  String get display => _display;
  String get previous => '${_op1.asString(true)} ${_getOperator()}';
  String get operator => _getOperator();

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
      case '/':
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
    _op1 = 0;
    _display = '0';
    _operator = _Operations.none;
  }

  void _buttonClearEntry() {
    _display = '0';
  }

  void _buttonDecimal() {
    if (_insertMode) {
      if (_op1 == 0) {
        _op1 = _getValueFromDisplay();
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
    _doOperation(_Operations.add);
  }

  void _buttonMinus() {
    _doOperation(_Operations.subtract);
  }

  void _buttonMultiply() {
    _doOperation(_Operations.multiply);
  }

  void _buttonDivide() {
    _doOperation(_Operations.divide);
  }

  void _buttonTotal() {
    _doOperation(_Operations.none);
    _op1 = 0;
  }

  double _getValueFromDisplay() {
    if (!_display.contains(',')) {
      return double.tryParse(_display) ?? 0;
    }
    return double.tryParse(_display.replaceAll('.', '').replaceAll(',', '.')) ??
        0;
  }

  String _getOperator() {
    switch (_operator) {
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

  double _calculate(double op1, double op2, _Operations operator) {
    switch (operator) {
      case _Operations.add:
        return op1 + op2;
      case _Operations.subtract:
        return op1 - op2;
      case _Operations.multiply:
        return op1 * op2;
      case _Operations.divide:
        if (op2 != 0) {
          return op1 / op2;
        }
      default:
        return 0;
    }
    return 0;
  }

  void _doOperation(_Operations operator) {
    //entering negative number?
    if (operator == _Operations.subtract && _operator != _Operations.add) {
      _op1 = _getValueFromDisplay();
      _operator = _Operations.subtract;
      _display = '-';
      _insertMode = false;
      return;
    }

    //first operation?
    if (_insertMode || _operator == _Operations.none) {
      _operator = operator;
    }
    if (_insertMode) return;

    //do previous calculation from stack
    var op2 = _getValueFromDisplay();
    //x-  -y >> x - y
    if (_operator == _Operations.subtract && op2 < 0) {
      _operator = _Operations.add;
    }
    _op1 = (_op1 == 0) ? _op1 = op2 : _calculate(_op1, op2, _operator);
    _display = _op1.asString(true);
    _insertMode = true;
    //store new operation
    _operator = operator;
  }
}
