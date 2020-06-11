// To parse this JSON data, do
//
//     final nextBus = nextBusFromJson(jsonString);

import 'dart:convert';

import 'package:stc_mobilitat_app/src/models/line.dart';

List<NextBus> nextBusFromJson(String str) => List<NextBus>.from(json.decode(str).map((x) => NextBus.fromJson(x)));

String nextBusToJson(List<NextBus> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NextBus {
    NextBus({
        this.idLinea,
        this.idTrayecto,
        this.idExpedicion,
        this.idParada,
        this.secuencia,
        this.codParada,
        this.nombreParada,
        this.minutos,
        this.minutosOrigen,
        this.subeBaja,
        this.latitud,
        this.longitud,
        this.linia,
        this.nomTrajecte,
        this.horapassada,
        this.horareal,
        this.faltenhores,
        this.faltenminuts,
    });

    int idLinea;
    int idTrayecto;
    int idExpedicion;
    int idParada;
    int secuencia;
    int codParada;
    NombreParada nombreParada;
    int minutos;
    int minutosOrigen;
    int subeBaja;
    double latitud;
    double longitud;
    Line linia;
    String nomTrajecte;
    bool horapassada;
    String horareal;
    String faltenhores;
    int faltenminuts;

    factory NextBus.fromJson(Map<String, dynamic> json) => NextBus(
        idLinea: json["IdLinea"],
        idTrayecto: json["IdTrayecto"],
        idExpedicion: json["IdExpedicion"],
        idParada: json["IdParada"],
        secuencia: json["Secuencia"],
        codParada: json["CodParada"],
        nombreParada: nombreParadaValues.map[json["NombreParada"]],
        minutos: json["Minutos"],
        minutosOrigen: json["MinutosOrigen"],
        subeBaja: json["SubeBaja"],
        latitud: json["Latitud"].toDouble(),
        longitud: json["Longitud"].toDouble(),
        linia: Line.fromJson(json["Linia"]),
        nomTrajecte: json["NomTrajecte"],
        horapassada: json["horapassada"],
        horareal: json["horareal"],
        faltenhores: json["faltenhores"],
        faltenminuts: json["faltenminuts"],
    );

    Map<String, dynamic> toJson() => {
        "IdLinea": idLinea,
        "IdTrayecto": idTrayecto,
        "IdExpedicion": idExpedicion,
        "IdParada": idParada,
        "Secuencia": secuencia,
        "CodParada": codParada,
        "NombreParada": nombreParadaValues.reverse[nombreParada],
        "Minutos": minutos,
        "MinutosOrigen": minutosOrigen,
        "SubeBaja": subeBaja,
        "Latitud": latitud,
        "Longitud": longitud,
        "Linia": linia.toJson(),
        "NomTrajecte": nomTrajecte,
        "horapassada": horapassada,
        "horareal": horareal,
        "faltenhores": faltenhores,
        "faltenminuts": faltenminuts,
    };
}

enum Adaptada { S, N }

final adaptadaValues = EnumValues({
    "N": Adaptada.N,
    "S": Adaptada.S
});

enum Color { THE_6735_A1, F7000_C, F70023, F70008 }

final colorValues = EnumValues({
    "#F70008": Color.F70008,
    "#F7000C": Color.F7000_C,
    "#F70023": Color.F70023,
    "#6735A1": Color.THE_6735_A1
});

enum Explotadora { SARBUS }

final explotadoraValues = EnumValues({
    "SARBUS": Explotadora.SARBUS
});

enum Forma { REDONDO }

final formaValues = EnumValues({
    "redondo": Forma.REDONDO
});

enum TextColor { CCFFFF }

final textColorValues = EnumValues({
    "#CCFFFF": TextColor.CCFFFF
});

enum Tipo { U, I }

final tipoValues = EnumValues({
    "I": Tipo.I,
    "U": Tipo.U
});

enum NombreParada { RBLA_DEL_CELLER_PG_TORRE_BLANCA }

final nombreParadaValues = EnumValues({
    "RBLA. DEL CELLER / PG. TORRE BLANCA": NombreParada.RBLA_DEL_CELLER_PG_TORRE_BLANCA
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
