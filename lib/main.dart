import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  LatLng _coordenades;

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: (GoogleMapController controller){},
            initialCameraPosition: CameraPosition(
              target: _coordenades = LatLng(41.472031, 2.086500),
              zoom: 14.5,
            ),
            zoomControlsEnabled: false,
          ),
        ],
      )
    ),
  );
}