import 'package:flutter/material.dart';
import 'package:stc_mobilitat_app/src/models/line.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class LineItem extends StatelessWidget {
  final Line line;
  LineItem({this.line});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
              color: HexColor(line.color),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: Text(
              line.code,
              style: TextStyle(color: HexColor(line.textColor), fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        title: Text(line.description),
      ),
    );
  }
}
