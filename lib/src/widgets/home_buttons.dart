import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stc_mobilitat_app/src/blocs/location/location_bloc.dart';
import 'package:stc_mobilitat_app/src/blocs/map/map_bloc.dart';

class HomeButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color _backgroundColor = Colors.white;    

    final mapBloc = BlocProvider.of<MapBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);    

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

    void _locationButton() => mapBloc.moveCamera( locationBloc.state.location );

    void _menuButton() => Scaffold.of(context).openDrawer();

    void _closePanel() => mapBloc.add( OnClosePanel() );

    void _favoritesButton() => Navigator.pushNamed(context, 'favorites');

    return BlocBuilder<MapBloc, MapState>(
      builder: ( context, state ) {
        return SafeArea(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Stack(
              children: [     

                Positioned(
                  top: 0,
                  left: 0,
                  child: _button( 
                    iconData: state.panelOpened ? Icons.arrow_back : Icons.menu, 
                    onPressed: state.panelOpened ? _closePanel : _menuButton, 
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
    );
  }
}