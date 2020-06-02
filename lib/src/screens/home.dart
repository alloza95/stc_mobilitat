import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:stc_mobilitat_app/src/models/bus_stop.dart';
import 'package:stc_mobilitat_app/src/screens/favorites_screen.dart';
import 'package:stc_mobilitat_app/src/services/fetch_database.dart';
import '../widgets/my_drawer.dart';
import '../location.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Location location = Location();
  GoogleMapController _mapController;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  LatLng _coordenades;
  //Declarem una llista buida de Parades
  List<BusStop> _parades = [];
  //Declarem una llista buida de marcadors;
  List<Marker> _allMarkers = [];  

  //L'aplicació crida aquesta funció quan es crea l'estat
  @override
  void initState() {
    super.initState();
    Services.getBusStop().then((busStopList) {
      //Omplim la nostre llista amb la resposta
      _parades = busStopList;
      //Actualitzem l'estat
      setState(() {
        for (var i = 0; i < _parades.length; i++) {
          //Creem un marcador
          final marker = Marker(
            markerId: MarkerId(_parades[i].idParada.toString()),
            position: LatLng(
              _parades[i].parada.latitud,
              _parades[i].parada.longitud
            ),
            infoWindow: InfoWindow(
              title: _parades[i].parada.descParada)
          );
          //Afegim el marcador a la nostra llista de marcadors
          _allMarkers.add(marker);
        }
        _getLocation();
      });
    });
  }

  GoogleMap _googleMap() {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
      },
      initialCameraPosition: CameraPosition(
        target: _coordenades = LatLng(41.472031, 2.086500),
        zoom: 14.5,
      ),
      zoomControlsEnabled: false,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      markers: Set.from(_allMarkers),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
                        //Boto per anar a la pantalla "parades preferides"
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
                            () => {
                                  _getLocation()
                                },
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


  //TODO: Trobar la manera de posar els mètodes de localització en un altre arxiu a part
  //Obté la posició de l'usuari i el converteix en el centre del mapa
  Future<void> _getLocation() async {
    if (_permissionGranted != PermissionStatus.granted) {
      await _requestPermission();
    }

    final _locationResult = await location.getLocation();
    _locationData = _locationResult;

    setState(() {
      _coordenades = LatLng(_locationData.latitude, _locationData.longitude);
      _mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: _coordenades, zoom: 16.8)));
    });
  }

  //Li demana a l'usuari que doni permís a l'aplicació
  //per utilitzar la seva ubicació
  Future<void> _requestPermission() async {
    if (_permissionGranted != PermissionStatus.granted) {
      final permissionRequestedResult = await location.requestPermission();
      setState(() {
        _permissionGranted = permissionRequestedResult;
      });
      if (permissionRequestedResult != PermissionStatus.granted) {
        return;
      }
    }
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
