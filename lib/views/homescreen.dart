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

  bool verificar() {
    final abastecimentoProvider = Provider.of<Abastecimento>(context);
    if (abastecimentoProvider.ultimaMedia == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final abastecimentoProvider = Provider.of<Abastecimento>(context);

    double number = 0;
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
                          Text(
                            'R\$ 100,00',
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
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
                            child: verificar()
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
                                    arguments: number)
                                .then((value) {
                              setState(() {
                                abastecimentoProvider.ultimaMedia = value;
                              });
                              print(abastecimentoProvider.ultimaMedia);
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
                    number = abastecimentoProvider.itemsList[i].hodometroAtual;
                    return InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.SCREEN_ABASTECER);
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
