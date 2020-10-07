import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:location/location.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, MyLocationState> {
  LocationBloc() : super(MyLocationState());

  Location _location = Location();

  void checkGpsAndLocation() {
    
    this._location.hasPermission().then(( permission ){

      if ( permission != PermissionStatus.granted ) {

        print('No tens permís');

        this._location.requestPermission().then(( permission ) {
          (permission != PermissionStatus.granted)
            ? print('Segueixes sense permís')
            : initTracing();
        });

      } else {
        print('Tens permís');
        initTracing();
      }

    });
  }

  void initTracing() async {
    final locationData = await this._location.getLocation();
    final newLocation = new LatLng( locationData.latitude, locationData.longitude );
    add( OnLocationChange( newLocation ) );
  }

  @override
  Stream<MyLocationState> mapEventToState( LocationEvent event ) async* {
    
    if ( event is OnLocationChange ) {
      yield state.copyWith(
        existsLocation: true,
        location: event.location
      );
    }
  }
}
