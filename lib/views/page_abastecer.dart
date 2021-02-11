import 'dart:math';

import 'package:despesascar/models/abastecimento.dart';
import 'package:despesascar/routes/approutes.dart';
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

  final format = DateFormat('dd-MM-yyyy hh:mm a');
  var dataAtual = DateTime.now();

  double valorGasto = 0;
  double guardarUltimoValor = 0;
  double totalDinheiroGastoMes = 0;
  int count = 0;
  double guardaUltimoHodometro = 0;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    final receivedInfoAbastecer =
        ModalRoute.of(context).settings.arguments as Abastecimento;

    if (receivedInfoAbastecer.id != null) {
      valorController.text =
          receivedInfoAbastecer.valorAbastecimento.toString();
      litroController.text =
          receivedInfoAbastecer.litroAbastecimento.toString();
      hodometroAtualController.text =
          receivedInfoAbastecer.hodometroAtual.toString();
      tipoCombustivelController.text = receivedInfoAbastecer.tipoCombustivel;
    }
  }

  @override
  Widget build(BuildContext context) {
    final abastecimentoProvider = Provider.of<Abastecimento>(context);

    Abastecimento abastecer = Abastecimento();
    guardaUltimoHodometro = abastecimentoProvider.hodometroAtual;
    guardarUltimoValor = abastecimentoProvider.valorAbastecimento;

    void addAbastecimento() {
      var isValid = _formKey.currentState.validate();

      if (!isValid) {
        return;
      }

      _formKey.currentState.save();

      abastecer = Abastecimento(
        id: Random().nextInt(1000),
        valorAbastecimento: double.parse(valorController.text),
        litroAbastecimento: double.parse(litroController.text),
        hodometroAtual: double.parse(hodometroAtualController.text),
        hodometroAnterior: double.parse(hodometroAtualController.text),
        tipoCombustivel: tipoCombustivelController.text,
        dateTime: dataAtual,
        despesasDoMes: totalDinheiroGastoMes,
      );
      abastecimentoProvider.adicionarAbastecimento(abastecer);
    }

    double diferencaHodometro() {
      if (guardaUltimoHodometro == null) {
        guardaUltimoHodometro = 0;
        return abastecimentoProvider.hodometroAnterior - guardaUltimoHodometro;
      } else if (guardaUltimoHodometro != 0) {
        return abastecimentoProvider.hodometroAnterior - guardaUltimoHodometro;
      }
    }

    double somarGastos() {
      if (guardarUltimoValor == null) {
        guardarUltimoValor = 0;
        return abastecimentoProvider.valorAbastecimento += guardarUltimoValor;
      } else if (guardaUltimoHodometro != 0) {
        return abastecimentoProvider.valorAbastecimento += guardarUltimoValor;
      }
    }

    void limparCampos() {
      valorController.text = "";
      litroController.text = "";
      hodometroAtualController.text = "";
      tipoCombustivelController.text = "";
    }

    double ultimaMedia(double kmPercorrido, double litros) {
      return kmPercorrido / litros;
    }

    bool isContainHodometroAnterior() {
      if (abastecimentoProvider.hodometroAtual == null) {
        return false;
      } else {
        return true;
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
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      controller: valorController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: 'Valor',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Digite o valor do abastecimento.';
                        }
                      },
                      onSaved: (newValue) =>
                          abastecer.valorAbastecimento = double.parse(newValue),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      controller: litroController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: 'Litros',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Digite a quantidade de litros que entrou em seu veículo';
                        }
                      },
                      onSaved: (newValue) =>
                          abastecer.litroAbastecimento = double.parse(newValue),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      controller: hodometroAtualController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: 'Hodometro',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Digite o hodometro atual';
                        }
                      },
                      onSaved: (newValue) =>
                          abastecer.hodometroAtual = double.parse(newValue),
                    ),
                    SizedBox(height: 5),
                    isContainHodometroAnterior()
                        ? Text('Hodometro anterior: ' +
                            abastecimentoProvider.hodometroAtual.toString())
                        : Text("Hodometro anterior: 0"),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: tipoCombustivelController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: 'Tipo de Combustível',
                      ),
                      onSaved: (newValue) =>
                          abastecer.tipoCombustivel = newValue,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Qual combustivel escolheu neste abastecimento?';
                        }
                      },
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  child: Text('Calcular'),
                  onPressed: () {
                    setState(() {
                      addAbastecimento();
                    });

                    double litro = double.parse(litroController.text);
                    double valor = double.parse(valorController.text);

                    //Declaro o valor do valorAbastecimento para função somarGastos() funcionar.
                    abastecimentoProvider.valorAbastecimento = valor;

                    //Declaro o valor do hodometro anterior para função diferencaHodometro() funcionar.
                    abastecimentoProvider.hodometroAnterior =
                        abastecer.hodometroAnterior;

                    //Função que soma os gastos do mês.
                    abastecimentoProvider.despesasDoMes = somarGastos();

                    //Verifica se a lista tem mais de um item, se tiver, faz o calculo da média.
                    if (abastecimentoProvider.countList > 1) {
                      abastecimentoProvider.ultimaMedia =
                          ultimaMedia(diferencaHodometro(), litro);
                    }

                    limparCampos();
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//PRINTS DE ACOMPANHAMENTO

// abastecimentoProvider.valorAbastecimento = valor;
// print('Valor (Provider): ' +
//     abastecimentoProvider.valorAbastecimento.toString());

// abastecimentoProvider.litroAbastecimento = litro;
// print('Litro (Provider): ' +
//     abastecimentoProvider.litroAbastecimento.toString());

// abastecimentoProvider.hodometroAnterior =
//     abastecer.hodometroAnterior;
// print("Hodometro Anterior (Provider): " +
//     abastecimentoProvider.hodometroAtual.toString());

// abastecimentoProvider.hodometroAtual =
//     abastecer.hodometroAtual;
// print("Hodometro Atual (Provider): " +
//     abastecimentoProvider.hodometroAtual.toString());

// abastecimentoProvider.tipoCombustivel =
//     abastecer.tipoCombustivel;
// print("Tipo de Combustivel (Provider): " +
//     abastecimentoProvider.tipoCombustivel);

// print("Provider Valor: " +
//     abastecimentoProvider.valorAbastecimento.toString());
