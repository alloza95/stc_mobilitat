import 'package:flutter/material.dart';

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
      body: Center(
        child: Text('hola'),
      ),
    );
  }
}
