import 'package:http/http.dart' as http;
import 'package:stc_mobilitat_app/src/models/bus_stop.dart';
import 'package:stc_mobilitat_app/src/models/line_route.dart';

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