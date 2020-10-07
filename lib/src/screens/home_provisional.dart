import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:stc_mobilitat_app/src/blocs/location/location_bloc.dart';
import 'package:stc_mobilitat_app/src/blocs/map/map_bloc.dart';
import 'package:stc_mobilitat_app/src/services/fetch_database.dart';
import 'package:stc_mobilitat_app/src/widgets/my_drawer.dart';

class HomeProvisional extends StatefulWidget {
  @override
  _HomeProvisionalState createState() => _HomeProvisionalState();
}

class _HomeProvisionalState extends State<HomeProvisional> {

  @override
  void initState() {

    _loadMarkers();

    super.initState();
  }

  void _loadMarkers() async {

    final mapBloc = BlocProvider.of<MapBloc>(context);
    mapBloc.initMarkers();
    await Services.getBusStop().then(( busList ) => mapBloc.loadBusMarkers( busList ));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, MyLocationState>(
        builder: ( context , state ) {
          return Stack(
            children: [
              createMap( state ),
              createButtons( context, state )
            ],
          );
        } 
      ),
      drawer: getDrawer(context),
    );
  }

  Widget createMap( MyLocationState state ) {
    
    if ( !state.existsLocation ) {
      BlocProvider.of<LocationBloc>(context).checkGpsAndLocation();
      return Center( child: Text('Provisional Home') );
    }    

    final mapBloc = BlocProvider.of<MapBloc>(context);

    final cameraPosition = new CameraPosition(
      target: state.location,
      zoom: state.existsLocation ? 16.8 : 14
    );

    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return GoogleMap(
          initialCameraPosition: cameraPosition,
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          onMapCreated: mapBloc.initMap,
          markers: Set.from( mapBloc.state.allMarkers ),
        ); 
      },
    );

  }

  Widget createButtons( BuildContext context, MyLocationState state ) {

    final Color _backgroundColor = Colors.white;    

    final mapBloc = BlocProvider.of<MapBloc>(context);    

    Widget _button( {IconData iconData, Function onPressed, Color iconColor} ) {

      final Color _iconColor = iconColor ?? Colors.green;

      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _backgroundColor,
          border: Border.all(color: _iconColor, width: 1),
        ),
        child: IconButton(
          icon: Icon( iconData, color: _iconColor, size: 28, ),
          onPressed: onPressed,
        ),
      );
    }

    void _locationButton() => mapBloc.moveCamera( state.location );

    void _menuButton() => Scaffold.of(context).openDrawer();

    void _favoritesButton() => Navigator.pushNamed(context, 'favorites');

    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(12),
        child: Stack(
          children: [     

            Positioned(
              top: 0,
              left: 0,
              child: _button( 
                iconData: Icons.menu, 
                onPressed: _menuButton, 
                iconColor: Colors.black87 
              ),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              child: _button( 
                iconData: Icons.star, 
                onPressed: _favoritesButton 
              )
            ),

            Positioned(
              bottom: 0,
              right: 0,
              child: _button( 
                iconData: Icons.my_location, 
                onPressed: _locationButton 
              )
            )
          ],
        ),
      ),
    );
  }
}
                        