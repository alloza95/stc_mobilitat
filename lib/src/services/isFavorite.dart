import 'package:stc_mobilitat_app/src/globals/favoriteList.dart';
import 'package:stc_mobilitat_app/src/models/bus_stop.dart';

bool isFavorite(ParadaClass currentParada) {
  bool finalResult = false;
  for (var i = 0; i < favoritesList.length; i++) {
    if (currentParada.idParada == favoritesList[i].idParada) {
      finalResult = true;
    }
  }
  return finalResult;
}
