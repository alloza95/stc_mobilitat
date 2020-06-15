import 'package:flutter/material.dart';
import 'package:stc_mobilitat_app/src/globals/homePanelData.dart';
import 'package:stc_mobilitat_app/src/models/bus_stop.dart';
import 'package:stc_mobilitat_app/src/models/line.dart';
import 'package:stc_mobilitat_app/src/models/nextBus_busStop.dart';
import 'package:stc_mobilitat_app/src/globals/favoriteList.dart';
import 'package:stc_mobilitat_app/src/services/isFavorite.dart';
import 'package:stc_mobilitat_app/src/widgets/lineIcon.dart';

class HomePanel extends StatefulWidget {
  final double heightScreen, widthScreen;
  final String currentDescParada;
  final List<Line> linesBusStop;
  final List<BusStop> parades;
  final int markerFlag;
  final List<NextBus> nextBuses;
  //final Icon favoriteIcon;
  HomePanel({this.heightScreen, this.widthScreen, this.currentDescParada, this.linesBusStop, this.parades, this.markerFlag, this.nextBuses});
  @override
  _HomePanelState createState() => _HomePanelState();
}

class _HomePanelState extends State<HomePanel> {
  //Icon _favoriteIcon = widget.favoriteIcon;
  //int favoritesListFlag;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        //Header
        Container(
          height: widget.heightScreen * 0.25,
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
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 16),
                  height: 4,
                  width: 64,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.currentDescParada == null ? '' : widget.currentDescParada,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                //Llista de Linies de la parada
                //TODO: Aconseguir centrar la Llista
                Container(
                  width: widget.widthScreen,
                  height: 35,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => Container(
                      width: 10,
                    ),
                    itemCount: widget.linesBusStop.length,
                    itemBuilder: (context, index) => LineIcon(
                      line: widget.linesBusStop[index],
                      width: 50,
                      height: 35,
                      fontSize: 14,
                    )
                  ),
                ),
                IconButton(
                  icon: favoriteIcon,
                  onPressed: () {
                    if (isFavorite(widget.parades[widget.markerFlag].parada)) {
                      int id;
                      for (var i = 0; i < favoritesList.length; i++) {
                        if (widget.parades[widget.markerFlag].idParada == favoritesList[i].idParada) {
                          id = i;
                          break;
                        }
                      }                      
                      favoritesList.removeAt(id);
                      setState(() {
                        favoriteIcon = Icon(Icons.star_border);
                      });
                    } else {
                      favoritesList.add(widget.parades[widget.markerFlag].parada);
                      setState(() {
                        favoriteIcon = Icon(Icons.star);
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        //Llista de proxims busos
        Expanded(
          child: ListView.separated(
            itemCount: widget.nextBuses.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.black26,
            ),
            itemBuilder: (context, index) =>
                _listTileNextBus(widget.nextBuses[index]),
          ),
        )
      ],
    );
  }
  //export
  /*
  bool _isFavorite(ParadaClass currentParada) {
    bool finalResult = false;
    for (var i = 0; i < favoritesList.length; i++) {
      if (currentParada.idParada == favoritesList[i].idParada) {
        finalResult = true;
        favoritesListFlag = i;
      } else {
        finalResult = false;
      }
    }
    return finalResult;
  }
  */

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
    );
  }
}