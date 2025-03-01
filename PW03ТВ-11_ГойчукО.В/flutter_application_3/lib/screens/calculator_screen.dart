import 'dart:math';

import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController inputPower = TextEditingController();
  final TextEditingController inputError1 = TextEditingController();
  final TextEditingController inputError2 = TextEditingController();
  final TextEditingController inputPrice = TextEditingController();

  String result = '';

  double integral(double a, double b, int n, double Function(double) function) {
    double h = (b - a) / n;
    double sum = 0.0;
    for (int i = 0; i < n; i++) {
      double x = a + i * h;
      sum += function(x);
    }
    return sum * h;
  }

  void calculate() {
    double power = double.tryParse(inputPower.text.replaceAll(',', '.')) ?? 0.0;
    double error1 =
        double.tryParse(inputError1.text.replaceAll(',', '.')) ?? 0.0;
    double error2 =
        double.tryParse(inputError2.text.replaceAll(',', '.')) ?? 0.0;
    double price = double.tryParse(inputPrice.text.replaceAll(',', '.')) ?? 0.0;

    //задаємо значення границь інтегралу
    double upperLimit = power + power * 0.05;
    double lowerLimit = power - power * 0.05;

    //знаходимо значення інтегралу
    double deltaW1 = integral(lowerLimit, upperLimit, 1000, (x) {
      return 1 /
          (error1 * sqrt(2 * pi)) *
          exp(-pow(x - power, 2) / (2 * pow(error1, 2)));
    });

    //знаходимо значення прибутку та втрати до вдосконалення системи
    double W1 = power * 24 * (deltaW1 * 100).round() / 100;
    double profit1 = W1 * price;
    double W2 = power * 24 * ((1 - deltaW1) * 100).round() / 100;
    double lose1 = W2 * price;

    double result1 = profit1 - lose1;

    double deltaW2 = integral(lowerLimit, upperLimit, 1000, (x) {
      return 1 /
          (error2 * sqrt(2 * pi)) *
          exp(-pow(x - power, 2) / (2 * pow(error2, 2)));
    });

    //знаходимо значення прибутку та втрати після вдосконалення системи
    double W3 = power * 24 * (deltaW2 * 100).round() / 100;
    double profit2 = W3 * price;
    double W4 = power * 24 * ((1 - deltaW2) * 100).round() / 100;
    double lose2 = W4 * price;

    double result2 = profit2 - lose2;

    setState(() {
      result = """
Результати:
До вдосконалення системи:
Прибуток: ${profit1.toStringAsFixed(2)} тис. грн
Втрати: ${lose1.toStringAsFixed(2)} тис. грн
Загалом: ${result1.toStringAsFixed(2)} тис. грн
Після вдосконалення системи:
Прибуток: ${profit2.toStringAsFixed(2)} тис. грн
Втрати: ${lose2.toStringAsFixed(2)} тис. грн
Загалом: ${result2.toStringAsFixed(2)} тис. грн
""";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Калькулятор №3')),
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
                controller: inputPower,
                decoration: InputDecoration(labelText: 'power'),
              ),
              TextField(
                controller: inputError1,
                decoration: InputDecoration(labelText: 'error1'),
              ),
              TextField(
                controller: inputError2,
                decoration: InputDecoration(labelText: 'error2'),
              ),
              TextField(
                controller: inputPrice,
                decoration: InputDecoration(labelText: 'price'),
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
