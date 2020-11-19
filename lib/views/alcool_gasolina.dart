import 'package:despesascar/widget/input_alcool_gasolina.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class AlcoolGasolina extends StatefulWidget {
  @override
  _AlcoolGasolinaState createState() => _AlcoolGasolinaState();
}

String resultado;
bool isValid = false;

String melhorAbastecerCom(double valorAlcool, double valorGasolina) {
  double resultGasolina = valorGasolina * 0.7;
  var r = double.parse(resultGasolina.toStringAsFixed(2));
  if (r < valorAlcool) {
    resultado = 'Complete com alcool';
  } else if (r > valorAlcool) {
    resultado = 'Complete com gasolina';
  } else if (r == valorAlcool) {
    resultado = 'Os dois tem o mesmo custo benefício.';
  }
  return resultado;
}

class _AlcoolGasolinaState extends State<AlcoolGasolina> {
  void limpar() {
    setState(() {
      resultado = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    var alcoolController = MoneyMaskedTextController(decimalSeparator: '.');
    var gasolinaController = MoneyMaskedTextController(decimalSeparator: '.');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/icons8-serviço-de-carro-48.png',
              fit: BoxFit.contain,
              height: 48,
            ),
            SizedBox(width: 5),
            Text(
              'CarExpanses',
              style: TextStyle(color: Colors.blue[400]),
            ),
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: [
                    Input(
                      texto: 'Alcool',
                      controller: alcoolController,
                      func: limpar,
                    ),
                    Input(
                      texto: 'Gasolina',
                      controller: gasolinaController,
                    ),
                    Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FlatButton(
                        child: Text('Calcular'),
                        onPressed: () {
                          setState(() {
                            resultado = melhorAbastecerCom(
                                double.parse(alcoolController.text),
                                double.parse(gasolinaController.text));
                            isValid = true;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    isValid
                        ? Container(
                            width: double.infinity,
                            child: Column(
                              children: [
                                Image.asset(
                                  'lib/assets/check-clipart-gif-animation-18-unscreen.gif',
                                  height: 100,
                                ),
                                Text(resultado.toString()),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
