import 'package:flutter/material.dart';
import 'package:stc_mobilitat_app/src/globals/homePanelData.dart';
import 'package:stc_mobilitat_app/src/models/favorite_busStop.dart';
import 'package:stc_mobilitat_app/src/models/nextBus_busStop.dart';
import 'package:stc_mobilitat_app/src/globals/favoriteList.dart';
import 'package:stc_mobilitat_app/src/screens/route_line_screen.dart';
import 'package:stc_mobilitat_app/src/services/isFavorite.dart';
import 'package:stc_mobilitat_app/src/widgets/lineIcon.dart';

class HomePanel extends StatefulWidget {  
  final int markerFlag;  
  HomePanel({this.markerFlag});
  @override
  _HomePanelState createState() => _HomePanelState();
}

class _HomePanelState extends State<HomePanel> {  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        //Header
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: double.maxFinite,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    spreadRadius: 1,
                    offset: Offset(0, 3))
              ],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32))),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //ratlleta
                Container(
                  margin: EdgeInsets.only(bottom: 16),
                  height: 4,
                  width: 64,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
                Text(
                  currentDescParada,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                //Llista de Linies de la parada
                //TODO: implementar loading
                linesBusStop.isEmpty ? Center(child: Text('Ara mateix no hi han línies disponibles'),) : Container(
                  width: (linesBusStop.length)*58 > double.maxFinite ? double.maxFinite : ((linesBusStop.length)*58).toDouble(),                  
                  height: 25,
                  //color: Colors.green,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: linesBusStop.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: LineIcon(
                        line: linesBusStop[index],
                        width: 50,
                        height: 35,
                        fontSize: 14,
                      ),
                    )
                  ),
                ),
                IconButton(
                  icon: favoriteIconHomePanel,
                  onPressed: () {
                    if (isFavorite(parades[widget.markerFlag].parada)) {
                      int id;
                      for (var i = 0; i < favoritesList.length; i++) {
                        if (parades[widget.markerFlag].idParada == favoritesList[i].busStop.idParada) {
                          id = i;
                          break;
                        }
                      }                      
                      favoritesList.removeAt(id);
                      setState(() {
                        favoriteIconHomePanel = Icon(Icons.star_border);
                      });
                    } else {
                      FavoriteBusStop newFavoriteBusStop = new FavoriteBusStop(busStop: parades[widget.markerFlag].parada, linesBusStop: linesBusStop);
                      favoritesList.add(newFavoriteBusStop);
                      setState(() {
                        favoriteIconHomePanel = Icon(Icons.star);
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        //Llista de proxims busos
        //TODO: Quan cliques un bus hauria de portar-te al recorregut de la linia
        nextBuses.isEmpty ? Expanded(child: Center(child: Text('No hi han sortides previstes en els pròxims 90 minuts'))) : Expanded(
          child: ListView.separated(
            itemCount: nextBuses.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.black26,
            ),
            itemBuilder: (context, index) =>
                _listTileNextBus(nextBuses[index]),
          ),
        )
      ],
    );
  }

  ListTile _listTileNextBus(NextBus nextBus) {
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
    return ListTile(
      leading: LineIcon(
        line: nextBus.linia,
        width: 50,
        height: 35,
        fontSize: 14,
      ),
      title: Text(nextBus.nomTrajecte),
      subtitle: Text(nextBus.horareal),
      trailing: Text(_timeRemaining(nextBus.faltenminuts)),
      onTap: (){
        //TODO: provar si funciona
        //
        Navigator.pushNamed(
            context, 
            RouteScreen.routeName, 
            arguments: RouteScreen(
              codeLine: nextBus.linia.codLinea, 
              idLine: nextBus.idLinea, 
              descLine: nextBus.linia.descLinea
            ));
        //
      },
    );
  }
}