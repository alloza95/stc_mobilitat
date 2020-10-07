part of 'map_bloc.dart';

@immutable
class MapState {

  final bool readyMap;
  final int previousMarkerId;
  final List<Marker> allMarkers;

  MapState({ 
    this.readyMap = false, 
    this.previousMarkerId,
    List<Marker> allMarkers
  }) : this.allMarkers = (allMarkers != null) ? allMarkers : <Marker>[];

  MapState copyWith({
    bool readyMap,
    int previousMarkerId,
    List<Marker> allMarkers
  }) => MapState(
    readyMap: readyMap ?? this.readyMap,
    previousMarkerId: previousMarkerId ?? this.previousMarkerId,
    allMarkers: allMarkers ?? this.allMarkers
  );
}
