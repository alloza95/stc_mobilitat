import 'package:stc_mobilitat_app/src/globals/favoriteList.dart';
import 'package:stc_mobilitat_app/src/models/bus_stop.dart';

bool isFavorite(ParadaClass currentParada) {
  print('Welcome to isFavorite function');
  print('Lenght of favoritesList: ${favoritesList.length}');
  bool finalResult = false;
  for (var i = 0; i < favoritesList.length; i++) {
    print('bucle for $i');
    if (currentParada.idParada == favoritesList[i].idParada) {
      print('cumpleix la condició. Welcome to if.');
      finalResult = true;
    }
  }
  print('This is finalResult of isFavorite method: $finalResult');
  return finalResult;
}
