import 'package:flutter/material.dart';

class Lines {
  static pushLines(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Línies'),
        ),
        body: Center(
          child: Text('hola'),
        ),
      );
    }));
  }
}
