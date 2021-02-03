import 'package:despesascar/models/abastecimento.dart';
import 'package:despesascar/routes/approutes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailAbastecimento extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final abastecimentoProvider = Provider.of<List<Abastecimento>>(context);

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
      body: Column(
        children: [
          Text(
              'Valor do Abastecimento: ${abastecimentoProvider[0].valorAbastecimento}'),
          Text(
              'Quantidade de Litros: ${abastecimentoProvider[0].litroAbastecimento}'),
          Text('Combustivel: ${abastecimentoProvider[0].tipoCombustivel}'),
          Text('Hodometro: ${abastecimentoProvider[0].hodometroAtual}'),
        ],
      ),
    );
  }
}
