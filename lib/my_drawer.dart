import 'package:flutter/material.dart';

class myDrawer extends StatefulWidget {
  @override
  _myDrawerState createState() => _myDrawerState();
}

class _myDrawerState extends State<myDrawer> {
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
                  onPressed: ()=>{Navigator.pop(context)}, 
                  icon: Icon(Icons.arrow_back),
                  iconSize: 35.0,
                ),
                Text('StC Mobilitat',style: TextStyle(fontSize: 25.0),)
              ],
            ),
          ),
          _listTile('Parades preferides', Icons.star, ()=>{}),
          _listTile('Línies', Icons.business, ()=>{}),
          _listTile('Títols i tarifes', Icons.attach_money, ()=>{}),
          _listTile('Estat del servei', Icons.info, ()=>{}),
        ],
      ),
    );
  }

  Widget _listTile(String _title, IconData iconData, Function function){
    return ListTile(
      leading: Icon(iconData),
      title: Text(_title),
      onTap: function,
    );
  }
}