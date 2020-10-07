part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class OnReadyMap extends MapEvent {}

class OnReadyMarkers extends MapEvent {}

class OnLoadMarkers extends MapEvent{
  final List<Marker> allMarkers;
  OnLoadMarkers(this.allMarkers);
}

class OnTapMarker extends MapEvent {
  final int idBusStop;
  OnTapMarker(this.idBusStop);
}
