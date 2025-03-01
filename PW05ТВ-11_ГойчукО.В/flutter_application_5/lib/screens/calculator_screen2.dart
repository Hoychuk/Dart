import 'package:flutter/material.dart';

class CalculatorScreen2 extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen2> {
  final TextEditingController inputZPerA = TextEditingController();
  final TextEditingController inputZPerP = TextEditingController();
  final TextEditingController inputOmega = TextEditingController();
  final TextEditingController inputTV = TextEditingController();
  final TextEditingController inputPm = TextEditingController();
  final TextEditingController inputTm = TextEditingController();
  final TextEditingController inputKP = TextEditingController();

  String result = '';

  void calculate() {
    double zPerA = double.tryParse(inputZPerA.text.replaceAll(',', '.')) ?? 0.0;
    double zPerP = double.tryParse(inputZPerP.text.replaceAll(',', '.')) ?? 0.0;
    double omega = double.tryParse(inputOmega.text.replaceAll(',', '.')) ?? 0.0;
    double tV = double.tryParse(inputTV.text.replaceAll(',', '.')) ?? 0.0;
    double Pm = double.tryParse(inputPm.text.replaceAll(',', '.')) ?? 0.0;
    double Tm = double.tryParse(inputTm.text.replaceAll(',', '.')) ?? 0.0;
    double kP = double.tryParse(inputKP.text.replaceAll(',', '.')) ?? 0.0;

    //Проводимо розрахунки згідно формул
    double mWnedA = omega * tV * Pm * Tm;
    double mWnedP = kP * Pm * Tm;
    double mZper = zPerA * mWnedA + zPerP * mWnedP;

    setState(() {
      result = """
Результати:
Математичне сподівання аварійного недовідпущення електроенергії: ${mWnedA.toStringAsFixed(2)} кВт*год
Математичне сподівання планового недовідпущення електроенергії: ${mWnedP.toStringAsFixed(2)} кВт*год
Математичне сподівання збитків від переривання електропостачання: ${mZper.toStringAsFixed(2)} грн
""";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator 2')),
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
                controller: inputZPerA,
                decoration: InputDecoration(
                  labelText: 'Збитки аварійних вимкнень (грн/кВт*год):',
                ),
              ),
              TextField(
                controller: inputZPerP,
                decoration: InputDecoration(
                  labelText: 'Збитки планових вимкнень (грн/кВт*год):',
                ),
              ),
              TextField(
                controller: inputOmega,
                decoration: InputDecoration(labelText: 'Частота відмов:'),
              ),
              TextField(
                controller: inputTV,
                decoration: InputDecoration(
                  labelText: 'Середній час відновлення трансформатора:',
                ),
              ),
              TextField(
                controller: inputPm,
                decoration: InputDecoration(labelText: 'Pm:'),
              ),
              TextField(
                controller: inputTm,
                decoration: InputDecoration(labelText: 'Tm:'),
              ),
              TextField(
                controller: inputKP,
                decoration: InputDecoration(
                  labelText: 'Середній час планового простою:',
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
