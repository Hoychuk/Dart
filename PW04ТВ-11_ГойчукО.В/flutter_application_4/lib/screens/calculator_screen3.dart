import 'dart:math';

import 'package:flutter/material.dart';

class CalculatorScreen3 extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen3> {
  final TextEditingController inputRcn = TextEditingController();
  final TextEditingController inputXcn = TextEditingController();
  final TextEditingController inputRcMin = TextEditingController();
  final TextEditingController inputXcMin = TextEditingController();

  String result = '';

  double SNom = 6.3;
  double Uh = 115.0;
  double Ul = 11.0;
  double UkMax = 11.1;

  void calculate() {
    double Rcn = double.tryParse(inputRcn.text.replaceAll(',', '.')) ?? 0.0;
    double Xcn = double.tryParse(inputXcn.text.replaceAll(',', '.')) ?? 0.0;
    double RcMin = double.tryParse(inputRcMin.text.replaceAll(',', '.')) ?? 0.0;
    double XcMin = double.tryParse(inputXcMin.text.replaceAll(',', '.')) ?? 0.0;

    // Проводимо розрахунки згідно формул
    double XT = UkMax * pow(Uh, 2.0) / 100 / SNom;
    double Xsh = Xcn + XT;
    double Zsh = sqrt(pow(Rcn, 2.0) + pow(Xsh, 2.0));

    double XshMin = XcMin + XT;
    double ZshMin = sqrt(pow(RcMin, 2.0) + pow(XshMin, 2.0));

    double Ish3 = Uh * 1000 / sqrt(3.0) / Zsh;
    double Ish2 = Ish3 * sqrt(3.0) / 2;

    double IshMin3 = Uh * 1000 / sqrt(3.0) / ZshMin;
    double IshMin2 = IshMin3 * sqrt(3.0) / 2;

    double Kpr = pow(Ul, 2.0) / pow(Uh, 2.0);

    double RshN = Rcn * Kpr;
    double XshN = Xsh * Kpr;
    double ZshN = sqrt(pow(RshN, 2.0) + pow(XshN, 2.0));

    double RshMinN = RcMin * Kpr;
    double XshMinN = XshMin * Kpr;
    double ZshMinN = sqrt(pow(RshMinN, 2.0) + pow(XshMinN, 2.0));

    double IshN3 = Ul * 1000 / sqrt(3.0) / ZshN;
    double IshN2 = IshN3 * sqrt(3.0) / 2;

    double IshMinN3 = Ul * 1000 / sqrt(3.0) / ZshMinN;
    double IshMinN2 = IshMinN3 * sqrt(3.0) / 2;

    double Rl = 7.91;
    double Xl = 4.49;

    double RSumN = Rl + RshN;
    double XSumN = Xl + XshN;
    double ZSumN = sqrt(pow(RSumN, 2.0) + pow(XSumN, 2.0));

    double RSumMinN = Rl + RshMinN;
    double XSumMinN = Xl + XshMinN;
    double ZSumMinN = sqrt(pow(RSumMinN, 2.0) + pow(XSumMinN, 2.0));

    double Iln3 = Ul * 1000 / sqrt(3.0) / ZSumN;
    double Iln2 = Iln3 * sqrt(3.0) / 2;

    double IlMinN3 = Ul * 1000 / sqrt(3.0) / ZSumMinN;
    double IlMinN2 = IlMinN3 * sqrt(3.0) / 2;

    setState(() {
      result = """
Результати:
Опір на шинах в нормальному режимі: ${Zsh.toStringAsFixed(2)} Ом
Опір на шинах в мінімальному режимі: ${ZshMin.toStringAsFixed(2)} Ом
Сила трифазного струму на шинах в нормальному режимі: ${Ish3.toStringAsFixed(2)} А
Сила двофазного струму на шинах в нормальному режимі: ${Ish2.toStringAsFixed(2)} А
Сила трифазного струму на шинах в мінімальному режимі: ${IshMin3.toStringAsFixed(2)} А
Сила двофазного струму на шинах в мінімальному режимі: ${IshMin2.toStringAsFixed(2)} А
Коефіцієнт приведення для визначення дійсних струмів: ${Kpr.toStringAsFixed(2)}
Опір на шинах в нормальному режимі: ${ZshN.toStringAsFixed(2)} Ом
Опір на шинах в мінімальному режимі: ${ZshMinN.toStringAsFixed(2)} Ом
Сила трифазного струму на шинах в нормальному режимі: ${IshN3.toStringAsFixed(2)} А
Сила двофазного струму на шинах в нормальному режимі: ${IshN2.toStringAsFixed(2)} А
Сила трифазного струму на шинах в мінімальному режимі: ${IshMinN3.toStringAsFixed(2)} А
Сила двофазного струму на шинах в мінімальному режимі: ${IshMinN2.toStringAsFixed(2)} А
Опір в точці 10 в нормальному режимі: ${ZSumN.toStringAsFixed(2)} Ом
Опір в точці 10 в мінімальному режимі: ${ZSumMinN.toStringAsFixed(2)} Ом
Сила трифазного струму в точці 10 в нормальному режимі: ${Iln3.toStringAsFixed(2)} А
Сила двофазного струму в точці 10 в нормальному режимі: ${Iln2.toStringAsFixed(2)} А
Сила трифазного струму в точці 10 в мінімальному режимі: ${IlMinN3.toStringAsFixed(2)} А
Сила двофазного струму в точці 10 в мінімальному режимі: ${IlMinN2.toStringAsFixed(2)} А
""";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Калькулятор струмів КЗ для підстанції Хмельницьких північних електричних мереж',
        ),
      ),
      body: SingleChildScrollView(
        // Додає скролінг
        keyboardDismissBehavior:
            ScrollViewKeyboardDismissBehavior
                .onDrag, // Закриває клавіатуру при скролі
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: inputRcn,
                decoration: InputDecoration(labelText: 'Rс.н. (Ом):'),
              ),
              TextField(
                controller: inputXcn,
                decoration: InputDecoration(labelText: 'Xс.н. (Ом):'),
              ),
              TextField(
                controller: inputRcMin,
                decoration: InputDecoration(labelText: 'Rс.min. (Ом):'),
              ),
              TextField(
                controller: inputXcMin,
                decoration: InputDecoration(labelText: 'Xс.min. (Ом):'),
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: calculate, child: Text('Розрахувати')),
              SizedBox(height: 20),
              Text(result, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
