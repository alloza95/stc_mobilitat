import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:stc_mobilitat_app/src/blocs/location/location_bloc.dart';
import 'package:stc_mobilitat_app/src/blocs/map/map_bloc.dart';
import 'package:stc_mobilitat_app/src/widgets/my_drawer.dart';

class HomeProvisional extends StatefulWidget {
  @override
  _HomeProvisionalState createState() => _HomeProvisionalState();
}

class _HomeProvisionalState extends State<HomeProvisional> {

  @override
  void initState() {
    super.initState();
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
      zoom: state.existsLocation ? 17.5 : 14
    );

    return GoogleMap(
      initialCameraPosition: cameraPosition,
      mapType: MapType.normal,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: mapBloc.initMap,
    );

  }

  Widget createButtons( BuildContext context, MyLocationState state ) {

    final double _radiusButton = 28.0;
    final Color _backgroundColor = Colors.white;    

    final mapBloc = BlocProvider.of<MapBloc>(context);

    Widget _button( {IconData iconData, Function onPressed, Color iconColor} ) {

      final Color _iconColor = iconColor ?? Colors.green;

      return Container(
        child: CircleAvatar(
          backgroundColor: _backgroundColor,
          maxRadius: _radiusButton,
          child: IconButton(
            icon: Icon( iconData, color: _iconColor ),
            onPressed: onPressed,
          ),
        ),
      );
    }

    void _locationButton() {
      final destination = state.location;
      mapBloc.moveCamera( destination );
    }

    void _menuButton() => Scaffold.of(context).openDrawer();

    void _favoritesButton() => Navigator.pushNamed(context, 'favorites');

    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [            
            _button( 
              iconData: Icons.menu, 
              onPressed: _menuButton, 
              iconColor: Colors.black87 
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [                
                _button( iconData: Icons.star, onPressed: _favoritesButton ),
                _button( iconData: Icons.my_location, onPressed: _locationButton )
              ],
            )
          ],
        ),
      ),
    );
  }
}
                        