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
  double tempAbastecimento;

  Abastecimento({
    this.id,
    this.valorAbastecimento,
    this.litroAbastecimento,
    this.tipoCombustivel,
    this.hodometroAtual,
    this.hodometroAnterior,
    this.dateTime,
    this.despesasDoMes,
    this.ultimaMedia,
    this.tempAbastecimento,
  });

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
      hodometroAnterior: abastecimento.hodometroAtual,
      tipoCombustivel: abastecimento.tipoCombustivel,
      dateTime: abastecimento.dateTime,
      despesasDoMes: abastecimento.despesasDoMes,
    ));
    notifyListeners();
  }

  void atualizarAbastecimento(Abastecimento abastecimento) {
    if (abastecimento.id == null && abastecimento == null) {
      return;
    }

    final index = _items.indexWhere((prod) => prod.id == abastecimento.id);

    if (index >= 0) {
      _items[index] = abastecimento;

      notifyListeners();
    }
  }

  void deletarAbastecimento(int id) {
    final index = _items.indexWhere((prod) => prod.id == id);

    if (index >= 0) {
      _items.removeWhere((abastecimento) => abastecimento.id == id);
      calculoDespesaMes();
      if (_items.length == 0) {
        despesasDoMes = 0;
      }
      notifyListeners();
    }
  }

  void calculoDespesaMes() {
    if (_items.length > 0) {
      Abastecimento ab = _items.reduce((first, second) => Abastecimento(
          valorAbastecimento:
              first.valorAbastecimento + second.valorAbastecimento));
      despesasDoMes = ab.valorAbastecimento;
    } else {
      despesasDoMes = 0;
      hodometroAtual = 0;
    }
  }

  double calculoUltimaMedia(double kmPercorrido, double litros) {
    return kmPercorrido / litros;
  }
}
