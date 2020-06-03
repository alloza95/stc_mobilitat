import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

// Arquitectura BLOC

class ServiceLocation {
  Location location = Location();
  PermissionStatus permission;
  LatLng coordenades = LatLng(41.472031, 2.086500);
  bool locationEnabled;

  //Mètode per obtenir les coordenades del usuari
  Future<LatLng> getMyLocation() async {
    if (permission != PermissionStatus.granted) {
      locationEnabled = false;
      await _requestPermission();
    }
    //
    if (permission == PermissionStatus.granted) {
      final _locationResult = await location.getLocation();
      coordenades = LatLng(_locationResult.latitude, _locationResult.longitude);
      //LocationData locationData = _locationResult;
    }
    return coordenades;
  }

  //Mètode per obtenir el permís de l'usuari
  Future<void> _requestPermission() async {    
    if (permission != PermissionStatus.granted) {
      final permissionRequestedResult = await location.requestPermission();
      permission = permissionRequestedResult;
      //
      if (permissionRequestedResult == PermissionStatus.granted) {
        locationEnabled = true;
      }
    }
  }
}

// Arquitectura BLOC. Instanciar la classe fora de qualsevol
// mètode o classe ens permet accedir a les dades desde
// tot el projecte.
var bloc = ServiceLocation();
