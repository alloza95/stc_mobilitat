import 'package:flutter/material.dart';
import 'package:stc_mobilitat_app/src/screens/favorites_screen.dart';
import 'package:stc_mobilitat_app/src/screens/service_state_screen.dart';
import 'package:stc_mobilitat_app/src/screens/titles_prices_screen.dart';
import '../screens/lines_screen.dart';

Drawer getDrawer(BuildContext context) {
  DrawerHeader _header() {
    return DrawerHeader(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: Icon(Icons.arrow_back),
            iconSize: 35.0,
          ),
          Text(
            'StC Mobilitat',
            style: TextStyle(fontSize: 25.0),
          )
        ],
      ),
    );
  }

  ListTile _getItem(IconData icon, String description, String route) {
    return ListTile(
      leading: Icon(icon),
      title: Text(description, style: TextStyle(fontSize: 15),),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }

  ListView _getList() {
    return ListView(
      children: <Widget>[
        _header(),
        _getItem(Icons.star, 'Parades preferides', FavoritesList.routeName),
        _getItem(Icons.business, 'Línies i parades', Lines.routeName),
        _getItem(
            Icons.attach_money, 'Títols i tarifes', TitlesPrices.routeName),
        _getItem(Icons.info, 'Estat del servei', Service.routeName),
      ],
    );
  }

  return Drawer(child: _getList());
}
