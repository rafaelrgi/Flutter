import 'package:flutter/material.dart';

class Imc extends ChangeNotifier {
  double _imc = 0;
  double _peso = 0;
  double _altura = 0;

  static const _descricoes = [
    'Abaixo do normal',
    'Normal',
    'Sobrepeso',
    'Obesidade grau 1',
    'Obesidade grau 2',
    'Obesidade grau 3',
  ];
  static const _valores = [
    18.5,
    25.0,
    30.0,
    35.0,
    40.0,
    999,
  ];

  double getImc() => _imc;

  bool canCalcular() => _peso > 10 && _peso < 999 && _altura > 1 && _altura < 3;

  void setPeso(String s) {
    _peso = s.isEmpty ? 0 : (num.tryParse(s)?.toDouble() ?? -1);
    _imc = !canCalcular() ? 0 : (_peso / (_altura * _altura) * 100).round() / 100;
    notifyListeners();
  }

  void setAltura(String s) {
    _altura = s.isEmpty ? 0 : (num.tryParse(s.replaceAll(',', '.'))?.toDouble() ?? -1);
    _imc = !canCalcular() ? 0 : (_peso / (_altura * _altura) * 100).round() / 100;
    notifyListeners();
  }

  String? getErroPeso() => _peso < 0 ? 'Peso inválido!' : null;
  String? getErroAltura() => _altura < 0 ? 'Altura inválida!' : null;

  String getImcDescricao() {
    return _descricoes[getFaixa()];
  }

  int getFaixa() {
    for (int i = 0; i < _valores.length; i++) {
      if (_imc < _valores[i]) return i;
    }
    return _valores.length - 1;
  }

  List<List<String>> getTabelaOms() {
    var rows = List<List<String>>.generate(
        _valores.length, (i) => List<String>.generate(2, (index) => '', growable: false),
        growable: false);

    if (canCalcular()) {
      for (var i = 0; i < _valores.length; i++) {
        //1º e último: rótulo diferente
        if (i == 0) {
          rows[i][0] = 'Menor que ${_valores[i]}'.replaceAll('.', ',');
        } else if (i == _valores.length - 1) {
          rows[i][0] = ' ${_valores[i - 1]} ou maior'.replaceAll('.', ',');
        } else {
          rows[i][0] = '${_valores[i - 1]} - ${_valores[i] - 0.1}'.replaceAll('.', ',');
        }

        rows[i][1] = _descricoes[i];
      }
    }
    return rows;
  }
}
