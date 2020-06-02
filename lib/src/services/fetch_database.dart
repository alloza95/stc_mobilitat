import 'package:http/http.dart' as http;
import 'package:stc_mobilitat_app/src/models/line_route.dart';

class Services{
  

  static Future<List<LineRoute>> getRoutes(String idLinea) async {
    //String id = idLinea;
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