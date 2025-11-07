import 'package:calculator/ui/view_models/calculator_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('2 ±', () async {
    //Setup
    calculatorViewModel.button('C');
    //Act
    calculatorViewModel.button('2');
    calculatorViewModel.button('±');
    //Assert
    expect(calculatorViewModel.display, '-2');
  });

  test('2 ± ±', () async {
    //Setup
    calculatorViewModel.button('C');
    //Act
    calculatorViewModel.button('2');
    calculatorViewModel.button('±');
    calculatorViewModel.button('±');
    //Assert
    expect(calculatorViewModel.display, '2');
  });

  test('2 + 2', () async {
    //Setup
    calculatorViewModel.button('C');
    //Act
    calculatorViewModel.button('2');
    calculatorViewModel.button('+');
    calculatorViewModel.button('2');
    calculatorViewModel.button('=');
    //Assert
    expect(calculatorViewModel.display, '4');
  });

  test('2 - 3', () async {
    //Setup
    calculatorViewModel.button('C');
    //Act
    calculatorViewModel.button('2');
    calculatorViewModel.button('-');
    calculatorViewModel.button('3');
    calculatorViewModel.button('=');
    //Assert
    expect(calculatorViewModel.display, '-1');
  });

  test('2 x 3', () async {
    //Setup
    calculatorViewModel.button('C');
    //Act
    calculatorViewModel.button('2');
    calculatorViewModel.button('x');
    calculatorViewModel.button('3');
    calculatorViewModel.button('=');
    //Assert
    expect(calculatorViewModel.display, '6');
  });

  test('12 ÷ 2', () async {
    //Setup
    calculatorViewModel.button('C');
    //Act
    calculatorViewModel.button('1');
    calculatorViewModel.button('2');
    calculatorViewModel.button('÷');
    calculatorViewModel.button('2');
    calculatorViewModel.button('=');
    //Assert
    expect(calculatorViewModel.display, '6');
  });

  test('-8 ÷ 2', () async {
    //Setup
    calculatorViewModel.button('C');
    //Act
    calculatorViewModel.button('-');
    calculatorViewModel.button('8');
    calculatorViewModel.button('÷');
    calculatorViewModel.button('2');
    calculatorViewModel.button('=');
    //Assert
    expect(calculatorViewModel.display, '-4');
  });

  test('2 + 2 = - 3', () async {
    //Setup
    calculatorViewModel.button('C');
    //Act
    calculatorViewModel.button('2');
    calculatorViewModel.button('+');
    calculatorViewModel.button('2');
    calculatorViewModel.button('=');
    calculatorViewModel.button('-');
    calculatorViewModel.button('3');
    calculatorViewModel.button('=');
    //Assert
    expect(calculatorViewModel.display, '1');
  });

  test('2 + 2 - 3', () async {
    //Setup
    calculatorViewModel.button('C');
    //Act
    calculatorViewModel.button('2');
    calculatorViewModel.button('+');
    calculatorViewModel.button('2');
    calculatorViewModel.button('-');
    calculatorViewModel.button('3');
    calculatorViewModel.button('=');
    //Assert
    expect(calculatorViewModel.display, '1');
  });

  test('9 + - 3 =', () async {
    //Setup
    calculatorViewModel.button('C');
    //Act
    calculatorViewModel.button('9');
    calculatorViewModel.button('+');
    calculatorViewModel.button('-');
    calculatorViewModel.button('3');
    calculatorViewModel.button('=');
    //Assert
    expect(calculatorViewModel.display, '6');
  });

  test('4 - + 3 =', () async {
    //Setup
    calculatorViewModel.button('C');
    //Act
    calculatorViewModel.button('4');
    calculatorViewModel.button('-');
    calculatorViewModel.button('+');
    calculatorViewModel.button('3');
    calculatorViewModel.button('=');
    //Assert
    expect(calculatorViewModel.display, '7');
  });

  test('2 / x 3 =', () async {
    //Setup
    calculatorViewModel.button('C');
    //Act
    calculatorViewModel.button('2');
    calculatorViewModel.button('/');
    calculatorViewModel.button('x');
    calculatorViewModel.button('3');
    calculatorViewModel.button('=');
    //Assert
    expect(calculatorViewModel.display, '6');
  });

  test('9 + - 3 + 2 / 4 =', () async {
    //Setup
    calculatorViewModel.button('C');
    //Act
    calculatorViewModel.button('9');
    calculatorViewModel.button('+');
    calculatorViewModel.button('-');
    calculatorViewModel.button('3');
    calculatorViewModel.button('+');
    calculatorViewModel.button('2');
    calculatorViewModel.button('÷');
    calculatorViewModel.button('4');
    calculatorViewModel.button('=');
    //Assert
    expect(calculatorViewModel.display, '2');
  });

  test('2 / 3 + ', () async {
    //Setup
    calculatorViewModel.button('C');
    //Act
    calculatorViewModel.button('2');
    calculatorViewModel.button('÷');
    calculatorViewModel.button('4');
    calculatorViewModel.button('=');
    //Assert
    expect(calculatorViewModel.display, '0,5');
  });
}
