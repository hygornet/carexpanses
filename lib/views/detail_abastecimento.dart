import 'package:despesascar/models/abastecimento.dart';
import 'package:despesascar/routes/approutes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailAbastecimento extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final format = DateFormat('dd/MM/yyyy hh:mm');
    // var dataAtual = DateTime.now();

    final abastecimento =
        ModalRoute.of(context).settings.arguments as Abastecimento;
    print('ID: ${abastecimento.id}');

    double precoPorLitragem =
        abastecimento.valorAbastecimento / abastecimento.litroAbastecimento;

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
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Data do Abastecimento: '),
                // Text(format.format(abastecimento.dateTime)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Valor do Abastecimento: '),
                Text(
                    'R\$ ${abastecimento.valorAbastecimento.toStringAsFixed(2)}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Litros: '),
                Text(abastecimento.litroAbastecimento.toStringAsFixed(2)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tipo de Combustível: '),
                Text(abastecimento.tipoCombustivel),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Preço por Litro: '),
                Text('R\$ ${precoPorLitragem.toStringAsFixed(2)}'),
              ],
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.SCREEN_ABASTECER,
                    arguments: abastecimento);
              },
              child: Text("Alterar dados"),
            ),
          ],
        ),
      ),
    );
  }
}
