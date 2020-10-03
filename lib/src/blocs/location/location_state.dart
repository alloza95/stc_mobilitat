part of 'location_bloc.dart';

@immutable
class MyLocationState {

  final bool existsLocation;
  final LatLng location;

  MyLocationState({
    this.existsLocation = false, 
    this.location
  });

  MyLocationState copyWith({
    bool existsLocation,
    LatLng location
  }) => new MyLocationState(
    existsLocation: existsLocation ?? this.existsLocation,
    location: location ?? this.location
  );
}
