import 'package:despesascar/widget/input_alcool_gasolina.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class AlcoolGasolina extends StatefulWidget {
  @override
  _AlcoolGasolinaState createState() => _AlcoolGasolinaState();
}

String resultado;
var img = '';
bool isValid = false;
var _formKey = GlobalKey<FormState>();

var alcoolController = MoneyMaskedTextController(
  decimalSeparator: '.',
);
var gasolinaController = MoneyMaskedTextController(
  decimalSeparator: '.',
);
String informacaoMelhorAbastecerCom =
    "O cálculo básico para se descobrir se o álcool é vantajoso ou não em relação à gasolina é simples. Basta dividir o preço do litro do etanol pelo da gasolina. Se o resultado for inferior a 0,7, o álcool é o melhor para abastecer. Se for maior que 0,7, então a gasolina é melhor.";

String melhorAbastecerCom(double valorAlcool, double valorGasolina) {
  double resultGasolina = valorGasolina * 0.7;
  var r = double.parse(resultGasolina.toStringAsFixed(2));
  if (r < valorAlcool) {
    resultado = 'Abasteça com álcool!';
  } else if (r > valorAlcool) {
    resultado = 'Abasteça com gasolina!';
  } else if (r == valorAlcool) {
    resultado = 'Os dois tem o mesmo custo benefício.';
  }
  return resultado;
}

class _AlcoolGasolinaState extends State<AlcoolGasolina> {
  void limpar() {
    setState(() {
      resultado = "";
      img = '';
      alcoolController.clear();
      gasolinaController.clear();
    });
  }

  void validarFormulario() {
    _formKey.currentState.validate();
  }

  @override
  Widget build(BuildContext context) {
    Future sair() async {
      isValid = false;
      Navigator.of(context).pop();
    }

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
      body: WillPopScope(
        onWillPop: () async {
          isValid = false;
          Navigator.of(context).pop();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(informacaoMelhorAbastecerCom),
                      SizedBox(height: 20),
                      Input(
                        texto: 'Alcool',
                        controller: alcoolController,
                        func: limpar,
                      ),
                      Input(
                        texto: 'Gasolina',
                        controller: gasolinaController,
                      ),
                      SizedBox(height: 20),
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
                              img =
                                  'lib/assets/check-clipart-gif-animation-18-unscreen.gif';
                              validarFormulario();
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
                                    img,
                                    height: 100,
                                  ),
                                  Text(
                                    resultado.toString(),
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
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
      ),
    );
  }
}
