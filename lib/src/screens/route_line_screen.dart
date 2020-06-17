import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stc_mobilitat_app/src/models/line_route.dart';
import 'package:stc_mobilitat_app/src/services/fetch_database.dart';
import 'package:stc_mobilitat_app/src/services/location.dart';
import 'package:stc_mobilitat_app/src/styles/icons/custom_icon_icons.dart';
import 'package:flutter/services.dart' show rootBundle;

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
  List<Parada> _finalRoute = [];
  List<Marker> _allMarkers = [];
  BitmapDescriptor defaultMarkerIcon;
  String _mapStyle;
  GoogleMapController _mapController;
  bool _isLoading = true;


  //El següent codi s'executa quan s'inicia l'estat
  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((onValue) {
      _mapStyle = onValue;
    });
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
      Services.getRoutes(args.idLine.toString()).then((routes) {
        
        //Omplim la llista de parades
        for (var i = 0; i < routes.length; i++) {
          int total = routes[i].trayectosDet.length - 1;
          if (i == 0) {            
            for (var x = 0; x < routes[i].trayectosDet.length; x++){              
              if (x == 0) {
                routes[i].trayectosDet[x].parada.idZona = 1;
              } else if (x == total){
                routes[i].trayectosDet[x].parada.idZona = 1;
              }else{
                routes[i].trayectosDet[x].parada.idZona = 0;
              }
              _finalRoute.add(routes[i].trayectosDet[x].parada);
            }
          }else{
            if (routes[i].trayectosDet.first.idParada == routes[i-1].trayectosDet.last.idParada){
              _finalRoute.removeLast();
              for (var x = 0; x < routes[i].trayectosDet.length; x++){
                if (x == 0) {
                  routes[i].trayectosDet[x].parada.idZona = 1;
                } else if (x == total){
                  routes[i].trayectosDet[x].parada.idZona = 1;
                }else{
                  routes[i].trayectosDet[x].parada.idZona = 0;
                }
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
          _allMarkers = _provisionalList;
          _isLoading = false;
        });
      });
    });
  }

  //Retorna el mapa de GoogleMaps
  GoogleMap _googleMap() {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
        controller.setMapStyle(_mapStyle);
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
    );
  }

  Widget _geoButton(){
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 1),
          shape: BoxShape.circle),
      child: FloatingActionButton(
        onPressed: () => {_getLocation()},
        backgroundColor: Colors.white,
        child: Icon(Icons.my_location,
            size: 36.0, color: Colors.green),
        heroTag: 'location',
      ),
    );
  }

  //Pregunta a l'usuari si dona permís per utilitzar l'ubicació,
  //i en cas afirmatiu, el centra en el mapa.
  void _getLocation() {
    bloc.getMyLocation().then((coordenades) {
      setState(() {
        _mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: coordenades, zoom: 16.8)));
      });
    });
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
            child: Stack(
              children: [
                _googleMap(),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: _geoButton()
                )
              ]
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5
                    )],
                    color: Theme.of(context).primaryColor
                  ),
                  child: Center(
                    child: Text(descLine),
                  ),
                ),
                _isLoading ? Center(child: CircularProgressIndicator()) : _listContent()                
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _listContent(){
    return _finalRoute.isEmpty 
      ? Expanded(
        child: Center(
          child: Text('Ara mateix no hi ha rutes disponibles per la línia $code')
        )
      )
      : Expanded(
        child: ListView.separated(
          itemCount: _finalRoute.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(_finalRoute[index].descParada, 
              style: _finalRoute[index].idZona == 0 
                ? TextStyle(fontSize: 14)
                : TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), 
            leading: Icon(CustomIcon.bus),
            onTap: (){
              LatLng _coordenades = LatLng(_finalRoute[index].latitud, _finalRoute[index].longitud);
              setState(() {
                _mapController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(target: _coordenades, zoom: 16.8)
                  )
                );
              });
            },
          ),
          separatorBuilder: (context, index) => Divider(),
        )
      );
  }
}
