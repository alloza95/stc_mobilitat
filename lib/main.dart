import 'package:flutter/material.dart';
import 'package:stc_mobilitat_app/src/screens/favorites_screen.dart';
import 'package:stc_mobilitat_app/src/screens/lines_screen.dart';
import 'package:stc_mobilitat_app/src/screens/service_state_screen.dart';
import 'package:stc_mobilitat_app/src/screens/titles_prices_screen.dart';
import 'src/home.dart';

void main() => runApp(MyApp());

// Aquest és el widget principal de l'aplicació
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Home(),
      routes: <String, WidgetBuilder>{
        FavoritesList.routeName: (BuildContext context) => FavoritesList(),
        Lines.routeName: (BuildContext context) => Lines(),
        TitlesPrices.routeName: (BuildContext context) => TitlesPrices(),
        Service.routeName: (BuildContext context) => Service()
      },
    );
  }
}
