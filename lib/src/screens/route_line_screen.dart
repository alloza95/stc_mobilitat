import 'package:flutter/material.dart';

class RouteLine extends StatefulWidget {
  static String routeName = '/route';
  @override
  _RouteLineState createState() => _RouteLineState();
}

class _RouteLineState extends State<RouteLine> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalla ruta'),
      ),
      body: Center(
        child: Text('hola'),
      ),
    );
  }
}