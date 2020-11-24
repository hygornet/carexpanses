import 'dart:math';

import 'package:flutter/cupertino.dart';

class Abastecimento with ChangeNotifier {
  int id;
  double valorAbastecimento;
  double litroAbastecimento;
  String tipoCombustivel;
  double hodometroAtual;
  double hodometroAnterior;
  DateTime dateTime;
  double despesasDoMes;
  double ultimaMedia;

  Abastecimento(
      {this.id,
      this.valorAbastecimento,
      this.litroAbastecimento,
      this.tipoCombustivel,
      this.hodometroAtual,
      this.hodometroAnterior,
      this.dateTime,
      this.despesasDoMes,
      this.ultimaMedia});

  List<Abastecimento> _items = [];

  List<Abastecimento> get itemsList => [..._items];

  int get countList {
    return _items.length;
  }

  void adicionarAbastecimento(Abastecimento abastecimento) {
    _items.add(Abastecimento(
      id: Random().nextInt(1000),
      valorAbastecimento: abastecimento.valorAbastecimento,
      litroAbastecimento: abastecimento.litroAbastecimento,
      hodometroAtual: abastecimento.hodometroAtual,
      tipoCombustivel: abastecimento.tipoCombustivel,
      dateTime: abastecimento.dateTime,
      despesasDoMes: abastecimento.despesasDoMes,
    ));
    notifyListeners();
  }
}
