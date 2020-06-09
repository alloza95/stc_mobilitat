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
  //Declarem el controlador del mapa
  GoogleMapController _mapController;

  BitmapDescriptor defaultMarkerIcon;
  BitmapDescriptor selectedMarkerIcon;

  int markerFlag;

  double sizeButton = 36.0;

  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  Function _showBottomSheetCallBack;

  @override
  void initState() {
    super.initState();
    _showBottomSheetCallBack = _showBottomSheet;
    //
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(40, 40)),
            'assets/default_busStop_icon.png')
        .then((onValue) {
      defaultMarkerIcon = onValue;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(40, 40)),
            'assets/selectedBusStop.png')
        .then((onValue) {
      selectedMarkerIcon = onValue;
    });
    //

    Services.getBusStop().then((busStopList) {
      //Omplim la nostre llista amb la resposta
      _parades = busStopList;

      setState(() {
        for (var i = 0; i < _parades.length; i++) {
          //Creem un marcador
          final marker = Marker(
            markerId: MarkerId(_parades[i].idParada.toString()),
            position:
                LatLng(_parades[i].parada.latitud, _parades[i].parada.longitud),
            infoWindow: InfoWindow(title: _parades[i].parada.descParada),
            icon: defaultMarkerIcon,
            onTap: () {
              if (markerFlag != i) {
                setState(() {
                  if (markerFlag != null) {
                    _allMarkers[markerFlag] = _allMarkers[markerFlag]
                        .copyWith(iconParam: defaultMarkerIcon);
                  }
                  _allMarkers[i] =
                      _allMarkers[i].copyWith(iconParam: selectedMarkerIcon);
                  markerFlag = i;
                });
                _showBottomSheetCallBack(_parades[i]);
              }
            },
          );
          //Afegim el marcador a la nostra llista de marcadors
          _allMarkers.add(marker);
        }
        _getLocation();
      });
    });
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

  void _showBottomSheet(BusStop parada) {
    /*setState(() {
     _showBottomSheetCallBack = null; 
    });
    */
    _scaffoldKey.currentState.showBottomSheet((context) {
      return new Container(
        height: 300,
        color: Colors.red,
        child: Center(
          child: Text(parada.parada.descParada),
        ),
      );
    })
        /*.closed
    .whenComplete((){
      if(mounted){
        setState(() {
         _showBottomSheetCallBack = _showBottomSheet; 
        });
      }
    })*/
        ;
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
      onTap: (value) {
        if (markerFlag != null) {
          setState(() {
            _allMarkers[markerFlag] =
                _allMarkers[markerFlag].copyWith(iconParam: defaultMarkerIcon);
            markerFlag = null;
          });
        }
      },
    );
  }

  //Retorna els 3 botons
  Widget _botons(BuildContext _context) {
    //
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //Botó per obrir el menú de navegació
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                shape: BoxShape.circle),
            child: FloatingActionButton(
              onPressed: () => Scaffold.of(_context).openDrawer(),
              backgroundColor: Colors.white,
              child: Icon(Icons.menu, size: sizeButton, color: Colors.black),
              heroTag: 'menu',
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Builder(
        builder: (context) => Stack(
          children: <Widget>[
            _googleMap(), 
            SafeArea(
              child: _botons(context)
            )
          ],
        ),
      ),
      drawer: getDrawer(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //Botó per anar a la pantalla "parades preferides"
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 1),
                  shape: BoxShape.circle),
              child: FloatingActionButton(
                onPressed: () =>
                    Navigator.pushNamed(context, FavoritesList.routeName),
                backgroundColor: Colors.white,
                child: Icon(Icons.star, size: sizeButton, color: Colors.green),
                heroTag: 'favorites',
              ),
            ),
            //Botó per geolocalitzar l'usuari
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 1),
                  shape: BoxShape.circle),
              child: FloatingActionButton(
                onPressed: () => {_getLocation()},
                backgroundColor: Colors.white,
                child: Icon(Icons.my_location,
                    size: sizeButton, color: Colors.green),
                heroTag: 'location',
              ),
            )
          ],
        ),
      ),
    );
  }
}
