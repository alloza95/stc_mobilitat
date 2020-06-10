import 'package:flutter/material.dart';
import 'package:stc_mobilitat_app/src/models/bus_stop.dart';
import 'package:stc_mobilitat_app/src/services/favoriteList.dart';

class FavoritesList extends StatefulWidget {
  static String routeName = '/favoritesList';

  @override
  _FavoritesListState createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parades preferides'),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black26,
        ),
        itemCount: favoritesList.length,
        itemBuilder: (context, index) => ParadaItem(parada: favoritesList[index],),
      )      
    );
  }
}

class ParadaItem extends StatelessWidget {
  final ParadaClass parada;
  ParadaItem({this.parada});

  @override
  Widget build(BuildContext context) {
    return ListTile(          
        title: Text(parada.descParada),
        subtitle: Text('Aqui apareixaran la llista de linies'),
        trailing: Icon(Icons.star),
    );
  }
}
