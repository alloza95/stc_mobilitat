import 'package:stc_mobilitat_app/src/models/bus_stop.dart';
import 'package:stc_mobilitat_app/src/models/line.dart';
import 'package:stc_mobilitat_app/src/models/nextBus_busStop.dart';

class FavoriteBusStop {
  ParadaClass busStop;
  List<NextBus> nextBuses;

  FavoriteBusStop({this.busStop, this.nextBuses});
}