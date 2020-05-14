import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  final Location location = Location();
  GoogleMapController _mapController;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  LatLng _coordenades;

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: (GoogleMapController controller){
              _mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: _coordenades = LatLng(41.472031, 2.086500),
              zoom: 14.5,
            ),
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
          ),
        ],
      )
    ),
  );

  //L'aplicació crida aquesta funció quan carrega main.dart
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLocation();
  }

  //Obté la posició de l'usuari i el converteix en el centre del mapa
  Future<void> _getLocation() async{
    if (_permissionGranted != PermissionStatus.granted) {
      await _requestPermission();
    }

    final _locationResult = await location.getLocation();
    _locationData = _locationResult;

    setState(() {
     _coordenades = LatLng(_locationData.latitude, _locationData.longitude);
     _mapController.animateCamera(
       CameraUpdate.newCameraPosition(
         CameraPosition(target: _coordenades, zoom: 16.8)
       )
     );
    });
  }

  //Li demana a l'usuari que doni permís a l'aplicació 
  //per utilitzar la seva ubicació
  Future<void> _requestPermission() async {
    if (_permissionGranted != PermissionStatus.granted) {
      final permissionRequestedResult =
          await location.requestPermission();
      setState(() {
        _permissionGranted = permissionRequestedResult;
      });
      if (permissionRequestedResult != PermissionStatus.granted) {
        return;
      }
    }
  }
}