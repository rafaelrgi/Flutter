import 'package:intl/intl.dart';

extension DoubleUtils on double {
  //

  String asString([bool separators = true, int precision = -1]) {
    if (!separators) {
      if (precision < 0) {
        return toString();
      }
      return toStringAsFixed(precision);
    }

    // With separators
    if (precision > 0) {
      final formatter = NumberFormat('#,##0.${'0' * precision}', 'pt_BR');
      return formatter.format(this);
    }

    if (precision == 0) {
      final formatter = NumberFormat('#,##0', 'pt_BR');
      return formatter.format(this);
    }

    final formatter = NumberFormat('#,##0', 'pt_BR');
    final integer = this < 1 ? '0' : formatter.format(this);
    var fractional = '';
    if (precision < 0) {
      fractional = toString();
    }
    if (fractional.isNotEmpty) {
      final parts = fractional.split('.');
      if (parts.length > 1 && parts[1] != '0') {
        return '$integer,${parts[1]}';
      }
    }

    return integer;
  }
}
