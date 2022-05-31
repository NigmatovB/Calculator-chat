import 'package:calculator/core/models/historyitem.dart';
import 'package:calculator/screens/sms_page.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CalculatorProvider with ChangeNotifier {
  String equation = '';
  String result = '';

  void addToEquation(String sign, bool canFirst, BuildContext context) {
    if (equation == '') {
      if (sign == '.') {
        equation = '0.';
      } else if (canFirst) {
        equation = sign;
      }
    } else {
      if (sign == "AC") {
        equation = '';
        result = '';
      } else if (sign == "⌫") {
        if (equation.endsWith(' ')) {
          equation = '${equation.substring(0, equation.length - 3)}';
        } else {
          equation = '${equation.substring(0, equation.length - 1)}';
        }
      } else if (equation.endsWith('.') && sign == '.') {
        return;
      } else if (equation.endsWith(' ') && sign == '.') {
        equation = equation + '0.';
      } else if (equation.endsWith(' ') && canFirst == false) {
        equation = '${equation.substring(0, equation.length - 3) + sign}';
      } else if (sign == '=') {
        if (equation == '00000') {
          
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SmsPage( 2 )));
        }
        if (equation == '110801') {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SmsPage( 1 )));
        }

        if (equation.length > result.length && result.length != 0) {
          final historyItem = HistoryItem()
            ..title = result
            ..subtitle = equation;
          Hive.box<HistoryItem>('history').add(historyItem);
        }
        equation = result;
      } else {
        equation = equation + sign;
      }
    }
    if (equation == '0') {
      equation = '';
    }
    try {
      var privateResult = equation.replaceAll('÷', '/').replaceAll('×', '*');
      Parser p = Parser();
      Expression exp = p.parse(privateResult);
      ContextModel cm = ContextModel();
      result = '${exp.evaluate(EvaluationType.REAL, cm)}';
      if (result.endsWith('.0')) {
        result = result.substring(0, result.length - 2);
      }
    } catch (e) {
      result = '';
    }
    notifyListeners();
  }
}
