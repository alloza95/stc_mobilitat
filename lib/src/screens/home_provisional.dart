import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:stc_mobilitat_app/src/blocs/location/location_bloc.dart';
import 'package:stc_mobilitat_app/src/blocs/map/map_bloc.dart';

import 'package:stc_mobilitat_app/src/services/fetch_database.dart';
import 'package:stc_mobilitat_app/src/widgets/home_buttons.dart';
import 'package:stc_mobilitat_app/src/widgets/home_panelProvisional.dart';

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

    final radiusPanel = Radius.circular(24);

    return Scaffold(
      body: SlidingUpPanel(
        controller: BlocProvider.of<MapBloc>( context ).initPanel(),
        panel: HomePanelProvisional(),
        minHeight: 0,
        maxHeight: MediaQuery.of(context).size.height,
        snapPoint: 0.5,
        borderRadius: BorderRadius.only( topLeft: radiusPanel, topRight: radiusPanel),
        body: BlocBuilder<LocationBloc, MyLocationState>(
          builder: ( context , state ) {
            return Stack(
              children: [
                createMap( state ),
                HomeButtons()
              ],
            );
          } 
        ),
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
}
                        