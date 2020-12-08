import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/painting.dart' show ImageConfiguration, Size;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:stc_mobilitat_app/src/blocs/location/location_bloc.dart';

import 'package:stc_mobilitat_app/src/models/bus_stop.dart';
import 'package:stc_mobilitat_app/src/styles/uber_map_theme.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState());

  GoogleMapController _mapController;

  PanelController _panelController;

  BitmapDescriptor _noSelectedMarker;
  BitmapDescriptor _selectedMarker;

  List<Marker> provisionalList = [];

  PanelController initPanel() {
    _panelController = new PanelController();
    add(OnReadyPanel());
    return _panelController;
  }

  void initMarkers() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(40, 40)),
            'assets/default_busStop_icon.png')
        .then((onValue) {
      _noSelectedMarker = onValue;
    });

    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(40, 40)),
            'assets/selectedBusStop.png')
        .then((onValue) {
      _selectedMarker = onValue;
    });
  }

  void initMap(GoogleMapController controller) {
    if (!state.readyMap) {
      this._mapController = controller;
      this._mapController.setMapStyle(jsonEncode(uberMapTheme));
      add(OnReadyMap());
    }
  }

  void moveCamera(LatLng destination) {
    final cameraUpdate = CameraUpdate.newLatLng(destination);
    this._mapController?.animateCamera(cameraUpdate);
  }

  void loadBusMarkers(List<BusStop> list) {
    for (var i = 0; i < list.length; i++) {
      final marker = Marker(
          markerId: MarkerId(list[i].idParada.toString()),
          position: LatLng(list[i].parada.latitud, list[i].parada.longitud),
          icon: _noSelectedMarker,
          infoWindow: InfoWindow(title: list[i].parada.descParada),
          onTap: () => add(OnTapMarker(i)));

      provisionalList.add(marker);
    }

    add(OnLoadMarkers(provisionalList));
  }

  void openPanel() {
    _panelController.animatePanelToPosition(0.25);
  }

  void closePanel() {
    _panelController.close();
  }

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is OnReadyMap) {
      yield state.copyWith(readyMap: true);

    } else if (event is OnReadyPanel) {
      yield state.copyWith(readyPanel: true);

    } else if (event is OnLoadMarkers) {
      yield state.copyWith(allMarkers: event.allMarkers);

    } else if (event is OnTapMarker) {
      yield* _onTapMarker(event);
      
    } else if (event is OnClosePanel) {
      closePanel();
      yield state.copyWith(panelOpened: false);
    }
  }

  Stream<MapState> _onTapMarker(OnTapMarker event) async* {
    final id = event.idBusStop;
    int previousId = state.previousMarkerId;

    if (provisionalList[id].icon == _noSelectedMarker) {
      provisionalList[id] =
          provisionalList[id].copyWith(iconParam: _selectedMarker);

      if (previousId != null) {
        provisionalList[previousId] =
            provisionalList[previousId].copyWith(iconParam: _noSelectedMarker);
      }

      previousId = id;
    }

    openPanel();

    yield state.copyWith(
        allMarkers: provisionalList,
        previousMarkerId: previousId,
        panelOpened: true);
  }
}
