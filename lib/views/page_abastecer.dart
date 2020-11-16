import 'dart:math';

import 'package:despesascar/models/abastecimento.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PageAbastecer extends StatefulWidget {
  @override
  _PageAbastecerState createState() => _PageAbastecerState();
}

class _PageAbastecerState extends State<PageAbastecer> {
  var litroController = TextEditingController();
  var valorController = TextEditingController();
  var alcoolController = TextEditingController();
  var gasolinaController = TextEditingController();
  var hodometroAnteriorController = TextEditingController();
  var hodometroAtualController = TextEditingController();
  var dateTimeController = TextEditingController();
  var tipoCombustivelController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var _formData = Map<String, Object>();
  Abastecimento abastecimento = Abastecimento();

  final format = DateFormat('dd-MM-yyyy');
  var dataAtual = DateTime.now();

  String resultado = "";
  double valorSomarGastos = 0;
  double totalValorGasto = 0;
  int count = 0;
  double calculo2;
  int c = 0;
  double guardarUltMedia;
  Map<String, Object> abastecimentoMap = {};

  @override
  Widget build(BuildContext context) {
    final abastecimentoProvider = Provider.of<Abastecimento>(context);

    var abastecer = Abastecimento();

    double modal = ModalRoute.of(context).settings.arguments;

    void addAbastecimento() {
      _formKey.currentState.save();
      abastecer = Abastecimento(
        id: Random().nextInt(1000),
        valorAbastecimento: double.parse(valorController.text),
        litroAbastecimento: double.parse(litroController.text),
        hodometroAtual: double.parse(hodometroAtualController.text),
        tipoCombustivel: tipoCombustivelController.text,
        dateTime: dataAtual,
        despesasDoMes: totalValorGasto,
      );
      abastecimentoProvider.adicionarAbastecimento(abastecer);
    }

    void limparCampos() {
      litroController.text = "";
      valorController.text = "";
      alcoolController.text = "";
      gasolinaController.text = "";
      hodometroAtualController.text = "";
      hodometroAnteriorController.text = "";
      tipoCombustivelController.text = "";
      dateTimeController.text = "";
    }

    double ultimaMedia(double kmPercorrido, double litros) {
      return kmPercorrido / litros;
    }

    double somarGastos(double value) {
      return value;
    }

    void melhorAbastecerCom(double valorAlcool, double valorGasolina) {
      double resultGasolina = valorGasolina * 0.7;
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: valorController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Valor',
                  ),
                  onSaved: (newValue) =>
                      abastecimento.valorAbastecimento = double.parse(newValue),
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: litroController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Litros',
                ),
                onSaved: (newValue) =>
                    abastecimento.litroAbastecimento = double.parse(newValue),
              ),
              SizedBox(height: 5),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: hodometroAtualController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Hodometro atual',
                ),
                onSaved: (newValue) =>
                    abastecimento.hodometroAtual = double.parse(newValue),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: tipoCombustivelController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Tipo de Combustível',
                ),
                onSaved: (newValue) => abastecimento.tipoCombustivel = newValue,
              ),
              SizedBox(height: 5),
              SizedBox(height: 5),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  child: Text('Calcular'),
                  onPressed: () {
                    double l = double.parse(litroController.text);
                    double v = double.parse(valorController.text);

                    valorSomarGastos = somarGastos(v);
                    totalValorGasto += valorSomarGastos;

                    setState(() {
                      count++;
                      addAbastecimento();
                      somarGastos(v);
                    });

                    limparCampos();

                    print("Valor: " + v.toString());
                    print("Litro: " + l.toString());
                    print("Hodometro Atual: " +
                        abastecer.hodometroAtual.toString());
                    print("Tipo de Combustivel: " + abastecer.tipoCombustivel);

                    print(modal);

                    if (modal != 0) {
                      calculo2 = abastecer.hodometroAtual - modal;
                      print("calculo: " + calculo2.toString());
                      guardarUltMedia = ultimaMedia(calculo2, l);
                      print("ultima media: " + guardarUltMedia.toString());
                      print("------------------------------------");
                      abastecimentoProvider.ultimaMedia = guardarUltMedia;

                      Navigator.of(context).pop(
                        abastecimentoProvider.ultimaMedia,
                      );
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              // Text('Última média: ${calcularUltimaMedia.toString()}'),
              Text('Nº de abastecimentos: ${count.toString()}'),
              Text('Despesas do mês: R\$${totalValorGasto.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }
}
