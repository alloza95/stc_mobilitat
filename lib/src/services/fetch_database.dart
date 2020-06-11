import 'package:http/http.dart' as http;
import 'package:stc_mobilitat_app/src/models/bus_stop.dart';
import 'package:stc_mobilitat_app/src/models/line.dart';
import 'package:stc_mobilitat_app/src/models/line_route.dart';
import 'package:stc_mobilitat_app/src/models/nextBus_busStop.dart';

class Services{

  static Future<List<BusStop>> getBusStop() async {
    
    String url = 'https://santqbus.santcugat.cat/consultamv.php?q=GetListaParadas';

    try {
      final response = await http.get(url);
      if (200 == response.statusCode) {
        final List<BusStop> busStops = busStopFromJson(response.body);
        return busStops;
      }else{
        return List<BusStop>();
      }
    } catch (e) {
      return List<BusStop>();
    }
  }

  static Future<List<NextBus>> getNextBuses(String id) async {
    
    String url = 'https://santqbus.santcugat.cat/consultamv.php?q=GetAllHorariosPrevistos&idparada=$id';

    try {
      final response = await http.get(url);
      if (200 == response.statusCode) {
        final List<NextBus> nextBuses = nextBusFromJson(response.body);
        return nextBuses;
      }else{
        return List<NextBus>();
      }
    } catch (e) {
      return List<NextBus>();
    }
  }

  static Future<List<Line>> getLines() async {
    
    String url = 'https://santqbus.santcugat.cat/consultamv.php?q=GetListaLineas';

    try {
      final response = await http.get(url);
      if (200 == response.statusCode) {
        final List<Line> lines = lineFromJson(response.body);
        for (var i = 0; i < lines.length; i++) {
          String codLinea = lines[i].codLinea;
          codLinea = codLinea.replaceAll(' ', '');
          if(codLinea.startsWith('Línia')){
            codLinea = codLinea.substring(5);
          }
          lines[i].codLinea = codLinea;
        }
        return lines;
      }else{
        return List<Line>();
      }
    } catch (e) {
      return List<Line>();
    }
  }

  static Future<List<LineRoute>> getRoutes(String idLinea) async {
    
    String urlRoutes = 'https://santqbus.santcugat.cat/consultamv.php?q=GetLinea&idgrupo=null&idlinea=$idLinea';

    try {
      final response = await http.get(urlRoutes);
      if (200 == response.statusCode) {
        final List<LineRoute> routes = routeFromJson(response.body);
        return routes;
      }else{
        return List<LineRoute>();
      }
    } catch (e) {
      return List<LineRoute>();
    }
  }  
}