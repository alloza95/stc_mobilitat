import 'package:flutter/material.dart';

class Service extends StatelessWidget {
  static String routeName = '/service';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estat del servei'),
      ),
      body: Center(
        child: Text('hola'),
      ),
    );
  }
}
