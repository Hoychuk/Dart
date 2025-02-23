import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController inputCoal = TextEditingController();
  final TextEditingController inputMasut = TextEditingController();
  final TextEditingController inputGas = TextEditingController();

  String result = '';

  void calculate() {
    double coal = double.tryParse(inputCoal.text.replaceAll(',', '.')) ?? 0.0;
    double masut = double.tryParse(inputMasut.text.replaceAll(',', '.')) ?? 0.0;
    double gas = double.tryParse(inputGas.text.replaceAll(',', '.')) ?? 0.0;

    // Розраховуємо коефіцієнти емісії та валовий викид твердих частинок вугілля
    double kCoal = 1000000 / 20.47 * 0.8 * 25.2 / (100 - 1.5) * (1 - 0.985);
    double ECoal = 0.000001 * kCoal * 20.47 * coal;

    // --\\-- мазуту
    double kMasut = 1000000 / 39.48 * 1 * 0.15 * (100 - 0) * (1 - 0.985);
    double EMasut = 0.000001 * kMasut * 39.48 * masut;

    // --\\-- природнього газу
    double kGas = 1000000 / 33.08 * 0 * 0 / (100 - 0) * (1 - 0.985);
    double EGas = 0.000001 * kGas * 33.08 * gas;

    setState(() {
      result = """
Результати:
При спалюванні твердого вугілля:
Показник емісії: ${kCoal.toStringAsFixed(2)}
Валовий викид: ${ECoal.toStringAsFixed(2)}
При спалюванні мазуту:
Показник емісії: ${kMasut.toStringAsFixed(2)} 
Валовий викид: ${EMasut.toStringAsFixed(2)}
При спалюванні природнього газу:
Показник емісії: ${kGas.toStringAsFixed(2)} 
Валовий викид: ${EGas.toStringAsFixed(2)}
При спалюванні природного газу тверді частинки відсутні, тому значення завжди буде рівне "нулю"
""";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Калькулятор валових викидів')),
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
                controller: inputCoal,
                decoration: InputDecoration(labelText: 'coal'),
              ),
              TextField(
                controller: inputMasut,
                decoration: InputDecoration(labelText: 'masut'),
              ),
              TextField(
                controller: inputGas,
                decoration: InputDecoration(labelText: 'gas'),
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
