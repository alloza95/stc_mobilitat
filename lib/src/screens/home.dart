import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stc_mobilitat_app/src/models/bus_stop.dart';
import 'package:stc_mobilitat_app/src/screens/favorites_screen.dart';
import 'package:stc_mobilitat_app/src/services/favoriteList.dart';
import 'package:stc_mobilitat_app/src/services/fetch_database.dart';
import '../widgets/my_drawer.dart';
import '../services/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  //Declarem una llista buida de parades
  List<BusStop> _parades = [];
  //Declarem una llista buida de marcadors
  List<Marker> _allMarkers = [];
  //Declarem el controlador del mapa
  GoogleMapController _mapController;
  //Declarem els icones dels marcadors
  BitmapDescriptor defaultMarkerIcon;
  BitmapDescriptor selectedMarkerIcon;
  //Bandera que controla si un marcador està seleccionat o no
  int markerFlag;
  //Guarda l'altura total de la pantalla del dispositiu
  double heightScreen;
  //Bandera que controla el marge inferior que han
  //de tenir els dos botons inferiors
  double marginBottomFab = 0;
  //Declarem el controlador del panell
  PanelController _panelController;

  //Dades pel panell
  String currentDescParada = '';
  Icon _favoriteIcon = Icon(Icons.star_border);
  int favoritesListFlag;
  //
  
  @override
  void initState() {
    super.initState();
    //Es crea el controlador del panell
    _panelController = new PanelController();

    //Es crea l'icona del marcador per defecte
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(40, 40)),
            'assets/default_busStop_icon.png')
        .then((onValue) {
      defaultMarkerIcon = onValue;
    });
    //Es crea l'icona del marcador seleccionat
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(40, 40)),
            'assets/selectedBusStop.png')
        .then((onValue) {
      selectedMarkerIcon = onValue;
    });

    Services.getBusStop().then((busStopList) {
      //Omplim la nostre llista amb la resposta
      _parades = busStopList;

      setState(() {
        for (var i = 0; i < _parades.length; i++) {
          //Creem un marcador
          final marker = Marker(
            markerId: MarkerId(_parades[i].idParada.toString()),
            position:
                LatLng(_parades[i].parada.latitud, _parades[i].parada.longitud),
            //infoWindow: InfoWindow(title: _parades[i].parada.descParada),
            icon: defaultMarkerIcon,
            onTap: () {
              //Comportament del panell
              if (_panelController.isPanelClosed != true) {
                _panelController.close().whenComplete(() {
                  updatePanel(_parades[i]);
                  _panelController.animatePanelToPosition(0.25);
                });
              } else {
                updatePanel(_parades[i]);
                _panelController.animatePanelToPosition(0.25);
              }
              //Canvi d'icona
              if (markerFlag != i) {
                setState(() {
                  if (markerFlag != null) {
                    _allMarkers[markerFlag] = _allMarkers[markerFlag]
                        .copyWith(iconParam: defaultMarkerIcon);
                  }
                  _allMarkers[i] =
                      _allMarkers[i].copyWith(iconParam: selectedMarkerIcon);
                  markerFlag = i;
                });
              }
            },
          );
          //Afegim el marcador a la nostra llista de marcadors
          _allMarkers.add(marker);
        }
        _getLocation();
      });
    });
  }

  //Pregunta a l'usuari si dona permís per utilitzar l'ubicació,
  //i en cas afirmatiu, el centra en el mapa.
  void _getLocation() {
    bloc.getMyLocation().then((coordenades) {
      setState(() {
        _mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: coordenades, zoom: 16.8)));
      });
    });
  }

  //Retorna el mapa de GoogleMaps
  GoogleMap _googleMap() {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
      },
      initialCameraPosition: CameraPosition(
        target: bloc.coordenades,
        zoom: 14.5,
      ),
      mapToolbarEnabled: false,
      zoomControlsEnabled: false,
      myLocationEnabled: bloc.locationEnabled,
      myLocationButtonEnabled: false,
      markers: Set.from(_allMarkers),
      onTap: (value) {
        if (markerFlag != null) {
          setState(() {
            _allMarkers[markerFlag] =
                _allMarkers[markerFlag].copyWith(iconParam: defaultMarkerIcon);
            markerFlag = null;
          });
        }
      },
    );
  }

  //Retorna els 3 botons
  Widget _botons(BuildContext _context) {
    //
    double sizeButton = 36.0;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //Botó per obrir el menú de navegació
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    shape: BoxShape.circle),
                child: FloatingActionButton(
                  onPressed: () => Scaffold.of(_context).openDrawer(),
                  backgroundColor: Colors.white,
                  child:
                      Icon(Icons.menu, size: sizeButton, color: Colors.black),
                  heroTag: 'menu',
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //Botó per anar a la pantalla "parades preferides"
              Container(
                margin: EdgeInsets.only(bottom: marginBottomFab),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 1),
                    shape: BoxShape.circle),
                child: FloatingActionButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, FavoritesList.routeName),
                  backgroundColor: Colors.white,
                  child:
                      Icon(Icons.star, size: sizeButton, color: Colors.green),
                  heroTag: 'favorites',
                ),
              ),
              //Botó per geolocalitzar l'usuari
              Container(
                margin: EdgeInsets.only(bottom: marginBottomFab),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 1),
                    shape: BoxShape.circle),
                child: FloatingActionButton(
                  onPressed: () => {_getLocation()},
                  backgroundColor: Colors.white,
                  child: Icon(Icons.my_location,
                      size: sizeButton, color: Colors.green),
                  heroTag: 'location',
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Obtenim l'altura de la pantalla
    heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SlidingUpPanel(
        body: Builder(
          builder: (context) => Stack(
            children: <Widget>[
              _googleMap(),
              SafeArea(child: _botons(context)),
            ],
          ),
        ),
        panel: _panel(),
        controller: _panelController,
        minHeight: 0,
        maxHeight: heightScreen,
        snapPoint: 0.5,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        onPanelSlide: (position) {
          if (position <= 0.5) {
            setState(() {
              marginBottomFab = heightScreen * position;
            });
          }
        },
      ),
      drawer: getDrawer(context),
    );
  }

  Widget _panel() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        //Header
        Container(
          height: heightScreen * 0.25,
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
                    currentDescParada,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: _favoriteIcon,
                  onPressed: () {
                    if(_isFavorite(_parades[markerFlag].parada)){
                      favoritesList.removeAt(favoritesListFlag);
                      setState(() {
                       _favoriteIcon = Icon(Icons.star_border); 
                      });
                    }else{
                      favoritesList.add(_parades[markerFlag].parada);
                      setState(() {
                       _favoriteIcon = Icon(Icons.star); 
                      });
                    }                    
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  bool _isFavorite(ParadaClass currentParada){
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

  void updatePanel(BusStop busStop) {
    currentDescParada = busStop.parada.descParada;
    if (_isFavorite(busStop.parada)) {
      setState(() {
       _favoriteIcon = Icon(Icons.star); 
      });
    }else{
      setState(() {
       _favoriteIcon = Icon(Icons.star_border); 
      });
    }
  }
}
