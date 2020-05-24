import 'package:flutter/material.dart';
import 'package:stc_mobilitat_app/src/models/line.dart';
import 'package:stc_mobilitat_app/src/widgets/line_item.dart';

class Lines extends StatefulWidget {
  static String routeName = '/lines';

  @override
  _LinesState createState() => _LinesState();
}

class _LinesState extends State<Lines> {
  buildList(){
    return <Line>[
      Line(1, 'L1', "MIRA-SOL-NUCLI - TORRENT DE FERRUSSONS", '#F70023', '#CCFFFF'),
      Line(2, 'L2A', "NUCLI - COLOMER - TURÓ DE CAN MATES", '#6735A1', '#CCFFFF'),
      Line(3, 'L3', "LES PLANES - LA FLORESTA - FGC SANT CUGAT", '#17CF00', '#CCFFFF'),
      Line(4, 'L4', "LA FLORESTA (BUS BARRI)", '#FFFF40', '#010515'),
    ];
  }

  List<LineItem> _buildContactList(){
    return buildList()
    .map<LineItem>((line) => LineItem(line: line))
    .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Línies'),
      ),
      body: ListView(
        children: _buildContactList(),
      )
    );
  }
}
