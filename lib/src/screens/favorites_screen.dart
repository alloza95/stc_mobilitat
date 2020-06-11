import 'package:flutter/material.dart';
import 'package:stc_mobilitat_app/src/models/bus_stop.dart';
import 'package:stc_mobilitat_app/src/services/favoriteList.dart';

class FavoritesList extends StatefulWidget {
  static String routeName = '/favoritesList';

  @override
  _FavoritesListState createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Parades preferides'),
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) => Divider(
                color: Colors.black26,
              ),
          itemCount: favoritesList.length,
          itemBuilder: (context, index) =>_listTile(context, favoritesList[index], index)
      )
    );
  }

  ListTile _listTile(BuildContext context, ParadaClass parada, int index) {

    return ListTile(
      title: Text(parada.descParada),
      subtitle: Text('Aqui apareixaran la llista de linies horitzontal'),
      trailing: IconButton(
        icon: Icon(Icons.star),
        onPressed: () {
          showDialog(
            context: context,
            builder: (alertContext) {
              return AlertDialog(
                title: Text('Eliminar'),
                content: Text(
                    '¿Estàs segur que vols eliminar aquesta parada de "preferides"?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.of(alertContext).pop();
                    },
                  ),
                  FlatButton(
                    child: Text('Si'),
                    onPressed: () {
                      Navigator.of(alertContext).pop();
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Parada eliminada'),
                      ));
                      setState(() {
                        favoritesList.removeAt(index);
                      });
                    },
                  )
                ],
              );
            }
          );
        },
      ),
    );
  }
}
