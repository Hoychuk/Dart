import 'dart:math';

import 'package:flutter/material.dart';

class CalculatorScreen2 extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen2> {
  final TextEditingController inputP = TextEditingController();
  final TextEditingController inputUsn = TextEditingController();

  String result = '';

  double SNom = 6.3;

  void calculate() {
    double P = double.tryParse(inputP.text.replaceAll(',', '.')) ?? 0.0;
    double Usn = double.tryParse(inputUsn.text.replaceAll(',', '.')) ?? 0.0;

    //Проводимо розрахунки згідно формул
    double Xc = (Usn * Usn) / P;
    double Xt = (Usn * Usn * Usn) / SNom / 100;

    double X = Xc + Xt;

    double Ip0 = Usn / sqrt(3.0) / X;

    setState(() {
      result = """
Результати:
Опори елементів заступної схеми: ${Xc.toStringAsFixed(2)} Ом і ${Xt.toStringAsFixed(2)} Ом
Сумарний опір: ${X.toStringAsFixed(2)} Ом
Початкове діюче значення струму трифазного КЗ: ${Ip0.toStringAsFixed(2)} кА
""";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Калькулятор струмів КЗ на шинах 10 кВ ГПП')),
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
                controller: inputP,
                decoration: InputDecoration(labelText: 'Потужність (МВ*А):'),
              ),
              TextField(
                controller: inputUsn,
                decoration: InputDecoration(
                  labelText: 'Середя номінальна напруга (кВ):',
                ),
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
