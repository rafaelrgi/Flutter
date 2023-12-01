import 'package:http_status/http_status/model.dart';
import 'package:test/test.dart';

void main() {
  final httpStatus = HttpStatus();

  test('HttpStatus não é null', () {
    expect(httpStatus, isNotNull);
  });

  test('Deve haver ao menos um status', () {
    expect(httpStatus.getCount(), greaterThanOrEqualTo(1));
  });

  test('1º status deve ser texto "Informational"', () {
    expect(httpStatus.getCode(0), matches('Informational'));
  });

  test('Código aleatório deve ser numérico (se não for ocorrerá exceção)', () {
    const repeat = 7;
    for (var i = 0; i < repeat; i++) {
      expect(httpStatus.getRandomCode(), isNotNaN);
    }
  });

  test('Código aleatório deve ser diferente do anterior', () {
    const repeat = 7;
    int previous = 0;
    for (var i = 0; i < repeat; i++) {
      expect(httpStatus.getRandomCode(), isNot(previous));
    }
  });
}
