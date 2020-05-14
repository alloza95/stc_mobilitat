import 'package:flutter/material.dart';

class TitlesAndPrices {
  static pushTitlesAndPrices(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Títols i tarifes'),
        ),
        body: Center(
          child: Text('hola'),
        ),
      );
    }));
  }
}
