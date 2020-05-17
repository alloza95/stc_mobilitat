import 'package:flutter/material.dart';

class Lines extends StatefulWidget {
  static String routeName = '/lines';

  @override
  _LinesState createState() => _LinesState();
}

class _LinesState extends State<Lines> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Línies'),
      ),
      body: Center(
        child: Text('hola'),
      ),
    );
  }
}
