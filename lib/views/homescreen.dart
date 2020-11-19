import 'package:despesascar/models/abastecimento.dart';
import 'package:despesascar/routes/approutes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool isContainUltimaMedia() {
    final abastecimentoProvider = Provider.of<Abastecimento>(context);
    if (abastecimentoProvider.ultimaMedia == null) {
      return false;
    } else {
      return true;
    }
  }

  bool isContainDespesasDoMes() {
    final abastecimentoProvider = Provider.of<Abastecimento>(context);
    if (abastecimentoProvider.despesasDoMes == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var alcoolController = TextEditingController();
    var gasolinaController = TextEditingController();
    String resultado = "";

    String melhorAbastecerCom(double valorAlcool, double valorGasolina) {
      double resultGasolina = valorGasolina * 0.7;
      var r = double.parse(resultGasolina.toStringAsFixed(2));
      if (r < valorAlcool) {
        return resultado = 'Complete com alcool';
      } else if (r > valorAlcool) {
        return resultado = 'Complete com gasolina';
      } else if (r == valorAlcool) {
        return resultado = 'Os dois tem o mesmo custo benefício.';
      }
    }

    final abastecimentoProvider = Provider.of<Abastecimento>(context);

    Map<String, Object> _info = Map<String, Object>();
    _info = {
      'hodometroAnterior': 0,
      'valorTotalGastos': abastecimentoProvider.despesasDoMes,
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'lib/assets/icons8-serviço-de-carro-48.png',
              fit: BoxFit.contain,
              height: 48,
            ),
            Text(
              'CarExpanses',
              style: TextStyle(
                color: Colors.blue[400],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.ALCOOL_GASOLINA);
              },
              child: Image.asset(
                'lib/assets/alcoolorgasolina3.png',
                fit: BoxFit.contain,
                height: 48,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 150,
                      ),
                      Column(
                        children: [
                          isContainDespesasDoMes()
                              ? Text(
                                  'R\$${abastecimentoProvider.despesasDoMes.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
                                )
                              : Text('R\$0.00',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white)),
                          SizedBox(height: 5),
                          Text('ESSE MÊS',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          FittedBox(
                            fit: BoxFit.cover,
                            child: isContainUltimaMedia()
                                ? Text(
                                    '${abastecimentoProvider.ultimaMedia.toStringAsFixed(2)} km/l',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  )
                                : Text('0.0 km/l',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white)),
                          ),
                          SizedBox(height: 5),
                          Text('ÚLTIMA MÉDIA',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              elevation: 3,
              color: Colors.blue,
            ),
            SizedBox(height: 5),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 150,
                        height: 80,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.SCREEN_ABASTECER,
                                    arguments: _info)
                                .then((value) {
                              setState(() {
                                _info = value;
                              });
                              print('Recebimento da outra tela: ' +
                                  _info.toString());
                            });
                          },
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Abastecer',
                                textAlign: TextAlign.center,
                              ),
                              Image.asset(
                                'lib/assets/fuel-removebg-preview.png',
                                fit: BoxFit.cover,
                                height: 48,
                                alignment: Alignment.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        width: 150,
                        height: 80,
                        child: RaisedButton(
                          onPressed: () {},
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Limpeza',
                                textAlign: TextAlign.center,
                              ),
                              Image.asset(
                                'lib/assets/kisspng-car-wash-super-wash-auto-detailing-5b3ab2a172b1d2.9630374215305734734698-removebg-preview.png',
                                fit: BoxFit.cover,
                                height: 48,
                                alignment: Alignment.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        width: 150,
                        height: 80,
                        child: RaisedButton(
                          onPressed: () {},
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Manutenção',
                                textAlign: TextAlign.center,
                              ),
                              Image.asset(
                                'lib/assets/car-maintenance-17-1133203-removebg-preview.png',
                                fit: BoxFit.cover,
                                height: 48,
                                alignment: Alignment.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: abastecimentoProvider.countList,
                  itemBuilder: (ctx, i) {
                    _info['hodometroAnterior'] =
                        abastecimentoProvider.itemsList[i].hodometroAtual;
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            AppRoutes.SCREEN_ABASTECER,
                            arguments: _info);
                      },
                      child: ListTile(
                        leading: Icon(Icons.directions_car),
                        title: Text(
                          'Abastecimento',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          abastecimentoProvider.itemsList[i].tipoCombustivel
                              .toString(),
                        ),
                        trailing: Text(
                            'R\$${abastecimentoProvider.itemsList[i].valorAbastecimento.toStringAsFixed(2)}'),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
