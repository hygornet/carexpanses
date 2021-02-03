import 'package:despesascar/routes/approutes.dart';
import 'package:despesascar/views/alcool_gasolina.dart';
import 'package:despesascar/views/detail_abastecimento.dart';
import 'package:despesascar/views/homescreen.dart';
import 'package:despesascar/views/page_abastecer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/abastecimento.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Abastecimento(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Car Expanses',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
        routes: {
          AppRoutes.SCREEN_ABASTECER: (ctx) => PageAbastecer(),
          AppRoutes.ALCOOL_GASOLINA: (ctx) => AlcoolGasolina(),
          AppRoutes.DETAIL_ABASTECIMENTO: (ctx) => DetailAbastecimento(),
        },
      ),
    );
  }
}
