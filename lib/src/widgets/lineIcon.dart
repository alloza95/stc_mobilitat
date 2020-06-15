import 'package:flutter/material.dart';
import 'package:stc_mobilitat_app/src/models/line.dart';
import 'package:stc_mobilitat_app/src/services/hexColor.dart';

class LineIcon extends StatelessWidget {
  final Line line;
  final double width, height;
  final double fontSize;

  LineIcon({this.line, this.width, this.height, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: HexColor(line.color),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Center(
        child: Text(
          line.codLinea,
          style: TextStyle(
              color: HexColor(line.textColor),
              fontSize: fontSize,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}