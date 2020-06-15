import 'package:flutter/material.dart';
import 'package:stc_mobilitat_app/src/models/line.dart';
import 'package:stc_mobilitat_app/src/screens/route_line_screen.dart';
import 'package:stc_mobilitat_app/src/widgets/lineIcon.dart';

class LineItem extends StatelessWidget {
  final Line line;
  LineItem({this.line});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: LineIcon(
          line: line, 
          width: 50, 
          height: 40, 
          fontSize: 20),
        title: Text(line.descLinea),
        onTap: () {
          print('apreto la línia ' + line.codLinea);
          Navigator.pushNamed(context, RouteScreen.routeName, arguments: RouteScreen(codeLine: line.codLinea, idLine: line.idLinea,));
        },
      ),
    );
  }
}
