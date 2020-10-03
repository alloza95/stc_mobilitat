part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {}

class OnLocationChange extends LocationEvent {

  final LatLng location;
  OnLocationChange(this.location);
}
