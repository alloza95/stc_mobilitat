import 'package:flutter/material.dart';
import 'package:stc_mobilitat_app/src/models/line_route.dart';
import 'package:stc_mobilitat_app/src/services/fetch_database.dart';
import 'package:stc_mobilitat_app/src/widgets/custom_tab_view.dart';

class RouteScreen extends StatefulWidget {
  final String codeLine;
  final int idLine;
  RouteScreen({this.codeLine, this.idLine});

  static String routeName = '/route';
  @override
  _RouteScreenState createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  RouteScreen args;
  String code = '';
  //Declarem una llista buida d'objectes LineRoute
  List<LineRoute> _routes = [];

  //El següent codi s'executa quan s'inicia l'estat
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        args = ModalRoute.of(context).settings.arguments;
        code = args.codeLine;
      });
      print('Estic al initState. Code: ' + args.codeLine);
      Services.getRoutes(args.idLine.toString()).then((routes) {
        setState(() {
          _routes = routes;
        });
      });
    });
  }

  //El widget que retornem
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(args.codeLine),
      ),
      body: CustomTabView(
        itemCount: _routes.length,
        tabBuilder: (context, index) =>
            Tab(text: 'Ruta ' + (index + 1).toString()),
        pageBuilder: (context, index) => _tabViewList(index),
      ),
    );
  }

  //Funció per crear una llista de parades a cada pageView
  _tabViewList(int i) {
    return ListView.builder(
        itemCount: _routes[i].trayectosDet == null
            ? 0
            : _routes[i].trayectosDet.length,
        itemBuilder: (context, index) {
          String nomParada = _routes[i].trayectosDet[index].parada.descParada;
          double long = _routes[i].trayectosDet[index].parada.longitud;
          double lat = _routes[i].trayectosDet[index].parada.latitud;
          return ListTile(
            title: Text(nomParada),
            subtitle: Text('Coordenades: ${long.toString()} ${lat.toString()}'),
          );
        });
  }
}
