import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController inputH = TextEditingController();
  final TextEditingController inputC = TextEditingController();
  final TextEditingController inputS = TextEditingController();
  final TextEditingController inputN = TextEditingController();
  final TextEditingController inputO = TextEditingController();
  final TextEditingController inputW = TextEditingController();
  final TextEditingController inputA = TextEditingController();

  String result = '';

  void calculate() {
    double H = double.tryParse(inputH.text.replaceAll(',', '.')) ?? 0.0;
    double C = double.tryParse(inputC.text.replaceAll(',', '.')) ?? 0.0;
    double S = double.tryParse(inputS.text.replaceAll(',', '.')) ?? 0.0;
    double N = double.tryParse(inputN.text.replaceAll(',', '.')) ?? 0.0;
    double O = double.tryParse(inputO.text.replaceAll(',', '.')) ?? 0.0;
    double W = double.tryParse(inputW.text.replaceAll(',', '.')) ?? 0.0;
    double A = double.tryParse(inputA.text.replaceAll(',', '.')) ?? 0.0;

    double Kpc = 100 / (100 - W);
    double Kpg = 100 / (100 - W - A);

    double Qrn = (339 * C + 1030 * H - 108.8 * (O - S) - 25 * W) / 1000;
    double Qcn = (Qrn + 0.025 * W) * Kpc;
    double Qgn = (Qrn + 0.025 * W) * Kpg;

    setState(() {
      result = """
Коефіцієнт переходу до сухої маси: ${Kpc.toStringAsFixed(2)}
Коефіцієнт переходу до горючої маси: ${Kpg.toStringAsFixed(2)}

Склад сухої маси:
H = ${(H * Kpc).toStringAsFixed(2)}%, C = ${(C * Kpc).toStringAsFixed(2)}%, S = ${(S * Kpc).toStringAsFixed(2)}%, N = ${(N * Kpc).toStringAsFixed(4)}%,  O = ${(O * Kpc).toStringAsFixed(2)}%,  A = ${(A * Kpc).toStringAsFixed(2)}%

Склад горючої маси:
H = ${(H * Kpg).toStringAsFixed(2)}%, C = ${(C * Kpg).toStringAsFixed(2)}%, S = ${(S * Kpg).toStringAsFixed(2)}%, N = ${(N * Kpg).toStringAsFixed(4)}%, O = ${(O * Kpg).toStringAsFixed(2)}%


Нижча теплота згоряння для робочої маси: ${Qrn.toStringAsFixed(5)} МДж/кг
Нижча теплота згоряння для сухої маси: ${Qcn.toStringAsFixed(5)} МДж/кг
Нижча теплота згоряння для горючої маси: ${Qgn.toStringAsFixed(5)} МДж/кг
""";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Калькулятор складу сухої та горючої маси')),
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
                controller: inputH,
                decoration: InputDecoration(labelText: 'H'),
              ),
              TextField(
                controller: inputC,
                decoration: InputDecoration(labelText: 'C'),
              ),
              TextField(
                controller: inputS,
                decoration: InputDecoration(labelText: 'S'),
              ),
              TextField(
                controller: inputN,
                decoration: InputDecoration(labelText: 'N'),
              ),
              TextField(
                controller: inputO,
                decoration: InputDecoration(labelText: 'O'),
              ),
              TextField(
                controller: inputW,
                decoration: InputDecoration(labelText: 'W'),
              ),
              TextField(
                controller: inputA,
                decoration: InputDecoration(labelText: 'A'),
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
