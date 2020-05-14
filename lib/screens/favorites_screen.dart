import 'package:flutter/material.dart';

class Favorites {
  static pushFavorites(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Parades preferides'),
        ),
        body: Center(
          child: Text('hola'),
        ),
      );
    }));
  }
}
