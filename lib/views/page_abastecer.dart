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

  final format = DateFormat('dd-MM-yyyy');
  var dataAtual = DateTime.now();

  double guardaSomarGastos = 0;
  double totalValorGasto = 0;
  int count = 0;
  double calculoUltimaMedia;
  double guardaUltimaMedia;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    final receivedInfoAbastecer =
        ModalRoute.of(context).settings.arguments as Abastecimento;

    final abastecimentoProvider =
        Provider.of<Abastecimento>(context, listen: false);

    if (receivedInfoAbastecer.id != null) {
      valorController.text =
          receivedInfoAbastecer.valorAbastecimento.toString();
      litroController.text =
          receivedInfoAbastecer.litroAbastecimento.toString();
      hodometroAtualController.text =
          receivedInfoAbastecer.hodometroAtual.toString();
      tipoCombustivelController.text = receivedInfoAbastecer.tipoCombustivel;
    } else {
      hodometroAtualController.text =
          abastecimentoProvider.ultimoHodometro.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final abastecimentoProvider = Provider.of<Abastecimento>(context);

    final receivedInfoAbastecer =
        ModalRoute.of(context).settings.arguments as Abastecimento;

    Abastecimento abastecer = Abastecimento();

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
        tipoCombustivel: tipoCombustivelController.text,
        dateTime: dataAtual,
        despesasDoMes: totalValorGasto,
      );

      abastecimentoProvider.adicionarAbastecimento(abastecer);
    }

    bool verificar() {
      if (abastecimentoProvider.ultimoHodometro.toString() == null) {
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
                    verificar()
                        ? Text(
                            'Hodometro anterior: ${abastecimentoProvider.ultimoHodometro.toString() ?? 0}')
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
                      count++;
                      addAbastecimento();
                    });

                    double litro = double.parse(litroController.text);
                    double valor = double.parse(valorController.text);
                    guardaSomarGastos = somarGastos(valor);
                    totalValorGasto += guardaSomarGastos;

                    limparCampos();

                    abastecimentoProvider.valorAbastecimento = totalValorGasto;
                    // _infoAbastecimento['valorTotalGastos'] = totalValorGasto;
                    print('Valor Total Gasto (Provider): ' +
                        abastecimentoProvider.valorAbastecimento.toString());

                    // print('Hodometro Anterior (Provider)' +
                    //     abastecimentoProvider.hodometroAnterior.toString());

                    print("Hodometro Atual: " +
                        abastecer.hodometroAtual.toString());

                    print("Tipo de Combustivel: " + abastecer.tipoCombustivel);

                    print(abastecimentoProvider.ultimoHodometro.toString());

                    // if (abastecimentoProvider.hodometroAnterior != 0) {
                    //   calculoUltimaMedia = abastecer.hodometroAtual -
                    //       abastecimentoProvider.hodometroAnterior;
                    //   print("calculo: " + calculoUltimaMedia.toString());
                    //   guardaUltimaMedia =
                    //       ultimaMedia(calculoUltimaMedia, litro);
                    //   print("ultima media: " + guardaUltimaMedia.toString());
                    //   print("------------------------------------");

                    //   abastecimentoProvider.ultimaMedia = guardaUltimaMedia;
                    //   abastecimentoProvider.despesasDoMes = totalValorGasto;

                    //   Navigator.of(context).pop();
                    // } else {
                    //   Navigator.of(context).pop();
                    // }
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
