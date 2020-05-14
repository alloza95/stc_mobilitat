import 'package:flutter/material.dart';
import 'screens/favorites_screen.dart';
import 'screens/lines_screen.dart';
import 'screens/titles_prices_screen.dart';
import 'screens/service_state_screen.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
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
          ),
          _listTile('Parades preferides', Icons.star,
              () => {Favorites.pushFavorites(context)}),
          _listTile('Línies', Icons.business, () => {Lines.pushLines(context)}),
          _listTile('Títols i tarifes', Icons.attach_money,
              () => {TitlesAndPrices.pushTitlesAndPrices(context)}),
          _listTile('Estat del servei', Icons.info,
              () => {ServiceState.pushServiceState(context)}),
        ],
      ),
    );
  }

  Widget _listTile(String _title, IconData iconData, Function function) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(_title),
      onTap: function,
    );
  }
}
