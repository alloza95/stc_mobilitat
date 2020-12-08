part of 'map_bloc.dart';

@immutable
class MapState {

  final bool readyMap;
  final bool readyPanel;
  final bool panelOpened;
  final int previousMarkerId;
  final List<Marker> allMarkers;

  MapState({ 
    this.readyMap = false, 
    this.readyPanel = false,
    this.panelOpened = false,
    this.previousMarkerId,
    List<Marker> allMarkers
  }) : this.allMarkers = (allMarkers != null) ? allMarkers : <Marker>[];

  MapState copyWith({
    bool readyMap,
    bool readyPanel,
    bool panelOpened,
    int previousMarkerId,
    List<Marker> allMarkers
  }) => MapState(
    readyMap: readyMap ?? this.readyMap,
    readyPanel: readyPanel ?? this.readyPanel,
    panelOpened: panelOpened ?? this.panelOpened,
    previousMarkerId: previousMarkerId ?? this.previousMarkerId,
    allMarkers: allMarkers ?? this.allMarkers
  );
}
