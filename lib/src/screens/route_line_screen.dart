import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stc_mobilitat_app/src/models/line_route.dart';
import 'package:stc_mobilitat_app/src/services/fetch_database.dart';
import 'package:stc_mobilitat_app/src/services/location.dart';
import 'package:stc_mobilitat_app/src/styles/icons/custom_icon_icons.dart';
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

  List<Polyline> _allPolylines = [];

  bool _routesFlag = true;

  GoogleMapController _mapController;

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
          if (_routes.isEmpty) {
            _routesFlag = false;
          }
        });
      });
    });
  }

  //Retorna el mapa de GoogleMaps
  GoogleMap _googleMap() {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
      },
      initialCameraPosition: CameraPosition(
        target: bloc.coordenades,
        zoom: 14.5,
      ),
      mapToolbarEnabled: false,
      zoomControlsEnabled: false,
      myLocationEnabled: bloc.locationEnabled,
      myLocationButtonEnabled: false,
      polylines: Set.from(_allPolylines),
      /*markers: Set.from(_allMarkers),
      onTap: (value){
        if (markerFlag != null) {
          setState(() {
            _allMarkers[markerFlag] = _allMarkers[markerFlag].copyWith(iconParam: defaultMarkerIcon);
            markerFlag = null;
          });
        }
      },*/
    );
  }

  //El widget que retornem
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(code),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            child: _googleMap(),
          ),
          Expanded(
            child: CustomTabView(
              itemCount: _routesFlag == false ? 1 : _routes.length,
              tabBuilder: (context, index) => _routesFlag == false
                  ? Tab(text: 'Rutes')
                  : Tab(text: 'Ruta ' + (index + 1).toString()),
              pageBuilder: (context, index) => _routesFlag == false
                  ? Center(child: Text('Ara mateix no hi ha rutes disponibles per la línia ${code}'))
                  : _tabView(index),
            ),
          ),
        ],
      ),
    );
  }

  //Funció per crear una llista de parades a cada pageView
  _tabView(int i) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: [BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5
            )]
          ),
          padding: EdgeInsets.all(15),
          child: Center(child: Text(_routes[i].descTrayecto))
        ),
        Expanded(
          child: ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: _routes[i].trayectosDet == null
                  ? 0
                  : _routes[i].trayectosDet.length,
              itemBuilder: (context, index) {
                String nomParada =
                    _routes[i].trayectosDet[index].parada.descParada;
                return ListTile(
                  leading: Icon(CustomIcon.bus),
                  title: Text(nomParada),
                );
              }),
        ),
      ],
    );
  }
}
