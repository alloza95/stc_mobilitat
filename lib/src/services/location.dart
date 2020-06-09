import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class ServiceLocation {
  //Iniciem el plugin Location
  Location location = Location();
  //Declarem la variable que controla si l'usuari dona permís o no
  PermissionStatus permission;
  //Declarem coordenades per defecte (el centre de la ciutat)
  LatLng coordenades = LatLng(41.472031, 2.086500);
  //Declarem la variable que controla la visibilitat del punter blau de GoogleMaps
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

// Instanciar la classe fora de qualsevol
// mètode o classe ens permet accedir a les dades desde
// tot el projecte.
var bloc = ServiceLocation();
