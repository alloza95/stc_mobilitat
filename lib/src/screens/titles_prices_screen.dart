import 'package:flutter/material.dart';

class TitlesPrices extends StatefulWidget {
  static String routeName = '/titlesPrices';
  @override
  _TitlesPricesState createState() => _TitlesPricesState();
}

class _TitlesPricesState extends State<TitlesPrices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Títols i tarifes'),
      ),
      body: Center(
        child: Text('hola'),
      ),
    );
  }
}
