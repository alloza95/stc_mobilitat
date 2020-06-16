import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:stc_mobilitat_app/src/models/bus_stop.dart';
import 'package:stc_mobilitat_app/src/models/line.dart';
import 'package:stc_mobilitat_app/src/models/nextBus_busStop.dart';

PanelController panelController;
List<BusStop> parades = [];
Icon favoriteIconHomePanel = Icon(Icons.star_border);
String currentDescParada = '';
List<NextBus> nextBuses = [];
List<Line> linesBusStop = [];
