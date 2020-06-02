import 'package:http/http.dart' as http;
import 'package:stc_mobilitat_app/src/models/line_route.dart';

class Services{
  static const String url = 'https://santqbus.santcugat.cat/consultamv.php?q=GetLinea&idgrupo=null&idlinea=36';

  static Future<List<LineRoute>> getRoutes() async {
    try {
      final response = await http.get(url);
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