import 'package:flutter/material.dart';
import 'package:stc_mobilitat_app/src/globals/favoriteList.dart';
import 'package:stc_mobilitat_app/src/models/favorite_busStop.dart';
import 'package:stc_mobilitat_app/src/widgets/lineIcon.dart';

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
        body: favoritesList.isEmpty
            ? Center(
                child: Text(
                'Actualment no tens parades preferides',
                style: TextStyle(fontSize: 16),
              ))
            : ListView.separated(
                separatorBuilder: (context, index) => Divider(
                      color: Colors.black26,
                    ),
                itemCount: favoritesList.length,
                itemBuilder: (context, index) =>
                    _listTile(context, favoritesList[index], index)));
  }
  //TODO: Quan cliques una parada hauries d'anar a la Home i tenir la parada oberta i localitzada
  Widget _listTile(
      BuildContext context, FavoriteBusStop favoriteBusStop, int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 70,
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(favoriteBusStop.busStop.descParada),
              favoriteBusStop.linesBusStop.isEmpty
                  ? Text('Ara mateix no hi han línies disponibles')
                  : Container(
                      margin: EdgeInsets.only(top: 8),
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: 25,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) => Container(
                                width: 10,
                              ),
                          itemCount: favoriteBusStop.linesBusStop.length,
                          itemBuilder: (context, index) => LineIcon(
                                line: favoriteBusStop.linesBusStop[index],
                                width: 50,
                                height: 25,
                                fontSize: 14,
                              )),
                    )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
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
                      });
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
