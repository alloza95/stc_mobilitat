import 'package:flutter/material.dart';
import 'package:stc_mobilitat_app/src/globals/favoriteList.dart';
import 'package:stc_mobilitat_app/src/models/favorite_busStop.dart';
import 'package:stc_mobilitat_app/src/services/fetch_database.dart';
import 'package:stc_mobilitat_app/src/styles/icons/custom_icon_icons.dart';
import 'package:stc_mobilitat_app/src/widgets/lineIcon.dart';

class FavoritesList extends StatefulWidget {
  static String routeName = '/favoritesList';

  @override
  _FavoritesListState createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    for (var i = 0; i < favoritesList.length; i++) {
      favoritesList[i].nextBuses = [];
      Services.getNextBuses(favoritesList[i].busStop.idParada.toString()).then((res){
        //Ordenem la llista de proxims busos en funció de la hora
        res.sort((a, b) {
          var adate = a.horareal;
          var bdate = b.horareal;
          return adate.compareTo(bdate);
        });

        for (var x = 0; x < res.length; x++) {
          if(x < 3){
            setState(() {
             favoritesList[i].nextBuses.add(res[x]); 
            });
          }
        }        
      });
    }
    super.initState();
  }

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
  Widget _listTile(BuildContext context, FavoriteBusStop favoriteBusStop, int index) {
    String _timeRemaining(int minuts){
      String resultat = '';
      if (minuts == 0 || minuts == 1) {
        resultat = 'Imminent';
      }else if(minuts/60 > 1){
        double hora = minuts/60;
        if (hora.truncate() == 1) {
          resultat = '1 hora';
        }else{
          resultat = hora.truncate().toString() + ' hores';
        }
      }else{
        resultat = minuts.toString() + ' min';
      }
      return resultat;
    }
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
              favoriteBusStop.nextBuses.isEmpty
                  ? Text('Ara mateix no hi han línies disponibles')
                  : Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Icon(CustomIcon.bus)),
                        Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 25,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: favoriteBusStop.nextBuses.length,
                          separatorBuilder: (context, index) => Container(width: 10),
                          itemBuilder: (context, index) => Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: LineIcon(
                                  line: favoriteBusStop.nextBuses[index].linia,
                                  width: 40,
                                  height: 25,
                                  fontSize: 14,
                                ),
                              ),
                              Text(_timeRemaining(favoriteBusStop.nextBuses[index].faltenminuts))
                            ],
                          ),
                        ),
                      )
                    ],),
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
