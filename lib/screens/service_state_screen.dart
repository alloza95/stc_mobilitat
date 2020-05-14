import 'package:flutter/material.dart';

class ServiceState {
  static pushServiceState(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Estat del servei'),
        ),
        body: Center(
          child: Text('hola'),
        ),
      );
    }));
  }
}
