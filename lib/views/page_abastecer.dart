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
  double guardaSomarGastos = 0;
  double totalValorGasto = 0;
  int count = 0;
  double calculoUltimaMedia;
  double guardaUltimaMedia;

  @override
  Widget build(BuildContext context) {
    final abastecimentoProvider = Provider.of<Abastecimento>(context);

    Abastecimento abastecer = Abastecimento();

    final _infoAbastecimento = ModalRoute.of(context).settings.arguments as Map;

    void addAbastecimento() {
      var isValid = _formKey.currentState.validate();

      if (!isValid) {
        return;
      }

      _formKey.currentState.save();
      abastecer = Abastecimento(
        id: Random().nextInt(1000),
        valorAbastecimento: _formData['valor'],
        litroAbastecimento: _formData['litro'],
        hodometroAtual: _formData['hodometro'],
        tipoCombustivel: _formData['combustivel'],
        dateTime: _formData['data'],
        despesasDoMes: _formData['despesaMes'],
      );

      abastecimentoProvider.adicionarAbastecimento(abastecer);
    }

    bool verificar() {
      if (_infoAbastecimento['hodometroAnterior'] == null) {
        return false;
      } else {
        return true;
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
                          _formData['valor'] = double.parse(newValue),
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
                          _formData['litro'] = double.parse(newValue),
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
                          _formData['hodometro'] = double.parse(newValue),
                    ),
                    SizedBox(height: 5),
                    verificar()
                        ? Text(
                            'Hodometro anterior: ${_infoAbastecimento['hodometroAnterior'].toString() ?? 0}')
                        : Text('Hodometro anterior: 0'),
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
                          _formData['combustivel'] = newValue,
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
                      count++;
                      addAbastecimento();
                    });
                    double litro = _formData['litro'];

                    double valor = abastecer.valorAbastecimento;
                    guardaSomarGastos = somarGastos(valor);
                    totalValorGasto += guardaSomarGastos;

                    _infoAbastecimento['valorTotalGastos'] = totalValorGasto;
                    print('MAP VALOR TOTAL GASTOS: ' +
                        _infoAbastecimento['valorTotalGastos'].toString());

                    limparCampos();

                    print("Hodometro Atual: " +
                        abastecer.hodometroAtual.toString());
                    print("Tipo de Combustivel: " + abastecer.tipoCombustivel);

                    print(_infoAbastecimento['hodometroAnterior']);

                    if (_infoAbastecimento['hodometroAnterior'] != 0) {
                      calculoUltimaMedia = abastecer.hodometroAtual -
                          _infoAbastecimento['hodometroAnterior'];
                      print("calculo: " + calculoUltimaMedia.toString());
                      guardaUltimaMedia =
                          ultimaMedia(calculoUltimaMedia, litro);
                      print("ultima media: " + guardaUltimaMedia.toString());
                      print("------------------------------------");

                      abastecimentoProvider.ultimaMedia = guardaUltimaMedia;
                      abastecimentoProvider.despesasDoMes = totalValorGasto;

                      Navigator.of(context).pop(
                        _infoAbastecimento,
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
