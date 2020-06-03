import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stc_mobilitat_app/src/models/bus_stop.dart';
import 'package:stc_mobilitat_app/src/screens/favorites_screen.dart';
import 'package:stc_mobilitat_app/src/services/fetch_database.dart';
import '../widgets/my_drawer.dart';
import '../services/location.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Declarem una llista buida de parades
  List<BusStop> _parades = [];
  //Declarem una llista buida de marcadors
  List<Marker> _allMarkers = [];

  GoogleMapController _mapController;

  @override
  void initState() {
    super.initState();
    Services.getBusStop().then((busStopList) {
      //Omplim la nostre llista amb la resposta
      _parades = busStopList;

      setState(() {
        for (var i = 0; i < _parades.length; i++) {
          //Creem un marcador
          final marker = Marker(
              markerId: MarkerId(_parades[i].idParada.toString()),
              position: LatLng(
                  _parades[i].parada.latitud, _parades[i].parada.longitud),
              infoWindow: InfoWindow(title: _parades[i].parada.descParada));
          //Afegim el marcador a la nostra llista de marcadors
          _allMarkers.add(marker);
        }
        _getLocation();
      });
    });
  }

  _getLocation() {
    bloc.getMyLocation().then((coordenades) {
      setState(() {
        _mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: coordenades, zoom: 16.8)));
      });
    });
  }

  GoogleMap _googleMap() {    
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
      },
      initialCameraPosition: CameraPosition(
        target: bloc.coordenades,
        zoom: 14.5,
      ),
      zoomControlsEnabled: false,
      myLocationEnabled: bloc.locationEnabled,
      myLocationButtonEnabled: false,
      markers: Set.from(_allMarkers),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Stack(
          children: <Widget>[
            _googleMap(),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      //Botó per obrir el menú de navegació
                      _createButton(
                          () => {Scaffold.of(context).openDrawer()},
                          Icon(
                            Icons.menu,
                            size: 36.0,
                            color: Colors.black,
                          ),
                          "menu")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      //Botó per anar a la pantalla "parades preferides"
                      _createButton(
                          () => {
                                Navigator.pushNamed(
                                    context, FavoritesList.routeName)
                              },
                          Icon(
                            Icons.star,
                            size: 36.0,
                            color: Colors.green,
                          ),
                          "favorites"),
                      //Botó per geolocalitzar l'usuari
                      _createButton(
                          () => {_getLocation()},
                          Icon(Icons.my_location,
                              size: 36.0, color: Colors.green),
                          "location")
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      drawer: getDrawer(context),
    );
  }

  //Funció per crear els FAB's de la pantalla main.dart
  Widget _createButton(Function function, Icon icon, String tag) {
    return FloatingActionButton(
      onPressed: function,
      backgroundColor: Colors.white,
      child: icon,
      heroTag: tag,
    );
  }
}
