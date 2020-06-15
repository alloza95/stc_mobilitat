import 'package:stc_mobilitat_app/src/models/bus_stop.dart';
import 'package:stc_mobilitat_app/src/models/line.dart';

class FavoriteBusStop {
  ParadaClass busStop;
  List<Line> linesBusStop;

  FavoriteBusStop({this.busStop, this.linesBusStop});
}