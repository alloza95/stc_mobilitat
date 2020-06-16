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
  final String descLine;
  RouteScreen({this.codeLine, this.idLine, this.descLine});

  static String routeName = '/route';
  @override
  _RouteScreenState createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  RouteScreen args;
  String code = '';
  String descLine = '';
  //Declarem una llista buida d'objectes LineRoute
 
  List<Parada> _finalRoute = [];
  List<Marker> _allMarkers = [];
  BitmapDescriptor defaultMarkerIcon;

  

  bool _routesFlag = true;

  GoogleMapController _mapController;

  //El següent codi s'executa quan s'inicia l'estat
  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(40, 40)),
            'assets/default_busStop_icon.png')
        .then((onValue) {
      defaultMarkerIcon = onValue;
    });
    Future.delayed(Duration.zero, () {
      setState(() {
        args = ModalRoute.of(context).settings.arguments;
        code = args.codeLine;
        descLine = args.descLine;
      });
      print('Estic al initState. Code: ' + args.codeLine);
      Services.getRoutes(args.idLine.toString()).then((routes) {
        
        //Omplim la llista de parades
        for (var i = 0; i < routes.length; i++) {
          if (i == 0) {
            for (var x = 0; x < routes[i].trayectosDet.length; x++){
              _finalRoute.add(routes[i].trayectosDet[x].parada);
            }
          }else{
            if (routes[i].trayectosDet.first.idParada == routes[i-1].trayectosDet.last.idParada){
              _finalRoute.removeLast();
              for (var x = 0; x < routes[i].trayectosDet.length; x++){
                _finalRoute.add(routes[i].trayectosDet[x].parada);
              }
            } 
          }                              
        }

        //Omplim la llista de Markers
        List<Marker> _provisionalList = [];
        for (var i = 0; i < _finalRoute.length; i++) {
          bool _exist = false;
          for( var x = 0; x < _provisionalList.length; x++){
            if (_provisionalList[x].markerId.toString() == _finalRoute[i].idParada.toString()) {
              _exist = true;
            }
          }
          if (!_exist) {
            final marker = Marker(
              markerId: MarkerId(_finalRoute[i].idParada.toString()),
              position: LatLng(_finalRoute[i].latitud, _finalRoute[i].longitud),
              infoWindow: InfoWindow(title: _finalRoute[i].descParada),
              icon: defaultMarkerIcon
            );
            _provisionalList.add(marker);
          }
        }

        setState(() {
          if (_finalRoute.isEmpty) {
            _routesFlag = false;
          }
          _allMarkers = _provisionalList;
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
      markers: Set.from(_allMarkers),
      //polylines: Set.from(_allPolylines),
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
              itemCount: 1,
              tabBuilder: (context, index) => _routesFlag == false
                  ? Tab(text: 'Rutes')
                  : Tab(text: 'Ruta ' + (index + 1).toString()),
              pageBuilder: (context, index) => _routesFlag == false
                  ? Center(child: Text('Ara mateix no hi ha rutes disponibles per la línia $code'))
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
          child: Center(child: Text(descLine))
        ),
        Expanded(
          child: ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: _finalRoute == null
                  ? 0
                  : _finalRoute.length,
              itemBuilder: (context, index) {
                String nomParada = _finalRoute[index].descParada;
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
