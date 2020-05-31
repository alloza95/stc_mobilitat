import 'package:flutter/material.dart';

// Passar dades a [route_line_screen] des de [lines_screen].

class RouteLine extends StatefulWidget {
  // 1. Definir les dades que necessito passar i el constructor.
  final String codeLine;
  RouteLine({this.codeLine});

  static String routeName = '/route';
  @override
  _RouteLineState createState() => _RouteLineState();
}

class _RouteLineState extends State<RouteLine> {
  RouteLine args;
  String code = '';

  @override
  void initState() {
    super.initState();
    // 2. Extreure les dades de la propietat settings del ModalRoute actual i
    // convertir-lo en un objecte RouteLine.
    // La classe Future ens permet accedir al context.
    Future.delayed(Duration.zero, (){
      setState(() {
        args = ModalRoute.of(context).settings.arguments;
        code = args.codeLine;
      });
      print('Estic al initState. Code: ' + args.codeLine);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalla ruta'),
      ),
      body: Center(
        // 3. Mostrar les dades extretes en el pas anterior.
        // (El pas 4 està a [line_item])
        child: Text(code),
      ),
    );
  }
}