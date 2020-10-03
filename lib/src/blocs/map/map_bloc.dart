import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState());

  GoogleMapController _mapController;

  void initMap( GoogleMapController controller ) {

    if ( !state.readyMap ) {
      this._mapController = controller;
      add( OnReadyMap() );
    }

  }

  void moveCamera( LatLng destination ) {

    final cameraUpdate = CameraUpdate.newLatLng( destination );
    this._mapController?.animateCamera( cameraUpdate );
    
  }

  @override
  Stream<MapState> mapEventToState( MapEvent event ) async* {
    
    if ( event is OnReadyMap ) {
      yield state.copyWith( readyMap: true );
    }

  }
}
