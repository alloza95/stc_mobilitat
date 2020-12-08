import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stc_mobilitat_app/src/blocs/location/location_bloc.dart';
import 'package:stc_mobilitat_app/src/blocs/map/map_bloc.dart';
import 'package:stc_mobilitat_app/src/screens/home_provisional.dart';

import 'src/screens/home.dart';
import 'package:stc_mobilitat_app/src/screens/favorites_screen.dart';
import 'package:stc_mobilitat_app/src/screens/lines_screen.dart';
import 'package:stc_mobilitat_app/src/screens/route_line_screen.dart';
import 'package:stc_mobilitat_app/src/screens/titles_prices_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LocationBloc()),
        BlocProvider(create: (_) => MapBloc())
      ],
      child: MaterialApp(
        title: 'StC Mobilitat',
        initialRoute: 'home_prov',
        routes: {
          'home': (_) => Home(),
          'home_prov': (_) => HomeProvisional(),
          'favorites': (_) => FavoritesList(),
          'lines': (_) => Lines(),
          'titles_prices': (_) => TitlesPrices(),
          'routes': (_) => RouteScreen()
        },
        theme: ThemeData(primaryColor: Colors.white, accentColor: Colors.green),
      ),
    );
  }
}
