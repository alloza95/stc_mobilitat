import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

Location location =  Location();
PermissionStatus _permissionGranted; 
LatLng _coordenades;

Future<void> _requestPermission() async {
  if (_permissionGranted != PermissionStatus.granted) {
    final permissionRequestedResult = await location.requestPermission();
    /*setState(() {
      _permissionGranted = permissionRequestedResult;
    });*/
    if (permissionRequestedResult != PermissionStatus.granted) {
      return;
    }
  }
}

Future<void> _getLocation() async {
  if (_permissionGranted != PermissionStatus.granted) {
    await _requestPermission();
  }
  final _locationResult = await location.getLocation();

  _coordenades = LatLng(_locationResult.latitude, _locationResult.longitude);

  /*setState(() {
    _coordenades = LatLng(_locationData.latitude, _locationData.longitude);
    _mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _coordenades, zoom: 16.8)));
  });*/
}

CameraPosition myLocation(){

  LatLng _getCoordinates(){
    _getLocation();
    return _coordenades;
  }

  return CameraPosition(
    target: _getCoordinates(),
    zoom: 16.8
  );
}