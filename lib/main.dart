import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FuelCalculator(),
    );
  }
}

class FuelCalculator extends StatefulWidget {
  @override
  _FuelCalculatorState createState() => _FuelCalculatorState();
}

class _FuelCalculatorState extends State<FuelCalculator> {
  final TextEditingController _alcoolController = TextEditingController();
  final TextEditingController _gasolinaController = TextEditingController();
  String _resultado = '';

  void _calcular() {
    double? precoAlcool = double.tryParse(_alcoolController.text);
    double? precoGasolina = double.tryParse(_gasolinaController.text);

    if (precoAlcool == null || precoGasolina == null) {
      _mostrarAlerta('Por favor, insira valores válidos para ambos os campos.');
      return;
    }

    double razao = precoAlcool / precoGasolina;

    setState(() {
      if (razao < 0.7) {
        _resultado = 'Abasteça com Álcool';
      } else {
        _resultado = 'Abasteça com Gasolina';
      }
    });
  }

  void _limpar() {
    setState(() {
      _alcoolController.clear();
      _gasolinaController.clear();
      _resultado = '';
    });
  }

  void _mostrarAlerta(String mensagem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erro'),
          content: Text(mensagem),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fuel Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _alcoolController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Preço do Álcool'),
            ),
            TextField(
              controller: _gasolinaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Preço da Gasolina'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcular,
              child: Text('Calcular'),
            ),
            ElevatedButton(
              onPressed: _limpar,
              child: Text('Limpar'),
            ),
            SizedBox(height: 20),
            Text(
              _resultado,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
