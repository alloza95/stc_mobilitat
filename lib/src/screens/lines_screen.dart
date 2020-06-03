import 'package:flutter/material.dart';
import 'package:stc_mobilitat_app/src/models/line.dart';
import 'package:stc_mobilitat_app/src/services/fetch_database.dart';
import 'package:stc_mobilitat_app/src/widgets/line_item.dart';

class Lines extends StatefulWidget {
  static String routeName = '/lines';

  @override
  _LinesState createState() => _LinesState();
}

class _LinesState extends State<Lines> {
  List<Line> _lines = <Line>[];

  @override
  void initState() {
    super.initState();
    Services.getLines()
      .then((lines) {
        setState(() {
          _lines = lines;
        });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Línies'),
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Colors.black26,
          ),
          itemCount: _lines.length,
          itemBuilder: (context, index) => LineItem(line: _lines[index]),
        ));
  }
}
