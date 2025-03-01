import 'dart:math';

import 'package:flutter/material.dart';

class CalculatorScreen1 extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen1> {
  final TextEditingController inputI = TextEditingController();
  final TextEditingController inputT = TextEditingController();
  final TextEditingController inputSm = TextEditingController();
  final TextEditingController inputJEk = TextEditingController();

  String result = '';

  double U = 10.0;

  void calculate() {
    double I = double.tryParse(inputI.text.replaceAll(',', '.')) ?? 0.0;
    double t = double.tryParse(inputT.text.replaceAll(',', '.')) ?? 0.0;
    double Sm = double.tryParse(inputSm.text.replaceAll(',', '.')) ?? 0.0;
    double jEk = double.tryParse(inputJEk.text.replaceAll(',', '.')) ?? 0.0;

    //Проводимо розрахунки згідно формул
    double Im = Sm / 2 / (sqrt(3.0) * U);
    double ImPA = 2 * Im;
    double sEk = Im / jEk;
    double s = I * 1000 * sqrt(t) / 92;

    setState(() {
      result = """
Результати:
Розрахунковий струм для нормального режиму: ${Im.toStringAsFixed(2)} А
Розрахунковий струм після аварійного режиму: ${ImPA.toStringAsFixed(2)} А
Економічний переріз: ${sEk.toStringAsFixed(2)} мм^2
Оптимальний переріз: ${s.toStringAsFixed(2)} мм^2
""";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Калькулятор кабелів для живлення двотрансворматорної підстанції',
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
                controller: inputI,
                decoration: InputDecoration(labelText: 'Струм КЗ (кА):'),
              ),
              TextField(
                controller: inputT,
                decoration: InputDecoration(labelText: 'Час вимикання (с):'),
              ),
              TextField(
                controller: inputSm,
                decoration: InputDecoration(labelText: 'Навантаженння (кВ*А):'),
              ),
              TextField(
                controller: inputJEk,
                decoration: InputDecoration(labelText: 'Е. густина (А/мм^2):'),
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
