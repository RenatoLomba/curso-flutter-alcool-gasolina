import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _alcoolController = TextEditingController();
  final TextEditingController _gasolinaController = TextEditingController();
  String _errorMessage = '';
  String _resultText = '';

  void _calculateResult() {
    double? alcoolValue = double.tryParse(_alcoolController.text);
    double? gasolinaValue = double.tryParse(_gasolinaController.text);

    if (alcoolValue == null) {
      setState(() {
        _errorMessage = 'Preço do álcool inválido, digite números maiores que 0 e utilizando (.)';
      });
      return;
    } else if (gasolinaValue == null) {
      setState(() {
        _errorMessage = 'Preço da gasolina inválida, digite números maiores que 0 e utilizando (.)';
      });
      return;
    } else {
      setState(() {
        _errorMessage = '';
      });
    }

    double calculationResult = alcoolValue / gasolinaValue;

    setState(() {
      _resultText = calculationResult >= 0.7 ?
        'É melhor abastecer com gasolina' :
        'É melhor abastecer com álcool';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('images/logo.png'),
              Padding(
                padding: const EdgeInsets.only(top: 64, bottom: 64),
                child: Column(
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                              'Saiba qual a melhor opção para abastecimento do seu carro',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              )
                          )
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Preço Álcool, ex: 1.59',
                        ),
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                        controller: _alcoolController,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Preço Gasolina, ex: 3.54',
                        ),
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                        controller: _gasolinaController,
                      ),
                    ]
                ),
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: _errorMessage.isNotEmpty ? 24 : 0
                      ),
                      child: Text(_errorMessage, style: const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      )),
                    ),
                    MaterialButton(
                      color: Colors.blue,
                      onPressed: _calculateResult,
                      textColor: Colors.white,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: const Text('Calcular', style: TextStyle(fontSize: 20)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                          _resultText,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                    )
                  ]
              )
            ],
          )
        ),
      ),
    );
  }
}
