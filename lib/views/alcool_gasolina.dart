import 'package:flutter/material.dart';

class AlcoolGasolina extends StatefulWidget {
  @override
  _AlcoolGasolinaState createState() => _AlcoolGasolinaState();
}

class _AlcoolGasolinaState extends State<AlcoolGasolina> {
  @override
  Widget build(BuildContext context) {
    var alcoolController = TextEditingController();
    var gasolinaController = TextEditingController();
    String guardarMelhorAbastecerCom = "";

    melhorAbastecerCom(double valorAlcool, double valorGasolina) {
      double resultGasolina = valorGasolina * 0.7;
      String resultado;
      var r = double.parse(resultGasolina.toStringAsFixed(2));
      if (r < valorAlcool) {
        resultado = 'Complete com alcool';
      } else if (r > valorAlcool) {
        resultado = 'Complete com gasolina';
      } else if (r == valorAlcool) {
        resultado = 'Os dois tem o mesmo custo benefício.';
      }
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('lib/assets/alcoolorgasolina5.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: alcoolController,
                      decoration:
                          InputDecoration(hintText: 'Digite o valor do alcool'),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: gasolinaController,
                      decoration: InputDecoration(
                          hintText: 'Digite o valor da gasolina'),
                    ),
                    Container(
                      width: double.infinity,
                      child: RaisedButton(
                        child: Text('CALCULAR'),
                        onPressed: () {
                          double resultGasolina =
                              double.parse(gasolinaController.text) * 0.7;
                          String resultado;
                          var r =
                              double.parse(resultGasolina.toStringAsFixed(2));
                          if (r < double.parse(alcoolController.text)) {
                            resultado = 'Complete com alcool';
                          } else if (r > double.parse(alcoolController.text)) {
                            resultado = 'Complete com gasolina';
                          } else if (r == double.parse(alcoolController.text)) {
                            resultado = 'Os dois tem o mesmo custo benefício.';
                          }
                          setState(() {
                            guardarMelhorAbastecerCom = resultado;
                          });
                        },
                      ),
                    ),
                    Text('Resultado: ' + guardarMelhorAbastecerCom),
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
