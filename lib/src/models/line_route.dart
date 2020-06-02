// To parse this JSON data, do
//
//     final route = routeFromJson(jsonString);

//Model creat amb quicktype.io

import 'dart:convert';

List<LineRoute> routeFromJson(String str) => List<LineRoute>.from(json.decode(str).map((x) => LineRoute.fromJson(x)));

String routeToJson(List<LineRoute> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LineRoute {
    LineRoute({
        this.idGrupo,
        this.idLinea,
        this.idTrayecto,
        this.idTrayectoSae,
        this.descTrayecto,
        this.descReducida,
        this.principal,
        this.sentido,
        this.iniTrayecto,
        this.finTrayecto,
        this.idTrayectoConcat,
        this.trayectosDet,
        this.ambHoraris,
    });

    int idGrupo;
    int idLinea;
    int idTrayecto;
    int idTrayectoSae;
    String descTrayecto;
    String descReducida;
    String principal;
    Senti sentido;
    int iniTrayecto;
    int finTrayecto;
    int idTrayectoConcat;
    List<TrayectosDet> trayectosDet;
    bool ambHoraris;

    factory LineRoute.fromJson(Map<String, dynamic> json) => LineRoute(
        idGrupo: json["ID_GRUPO"],
        idLinea: json["ID_LINEA"],
        idTrayecto: json["ID_TRAYECTO"],
        idTrayectoSae: json["ID_TRAYECTO_SAE"],
        descTrayecto: json["DESC_TRAYECTO"],
        descReducida: json["DESC_REDUCIDA"],
        principal: json["PRINCIPAL"],
        sentido: sentiValues.map[json["SENTIDO"]],
        iniTrayecto: json["INI_TRAYECTO"],
        finTrayecto: json["FIN_TRAYECTO"],
        idTrayectoConcat: json["ID_TRAYECTO_CONCAT"] == null ? null : json["ID_TRAYECTO_CONCAT"],
        trayectosDet: List<TrayectosDet>.from(json["TrayectosDet"].map((x) => TrayectosDet.fromJson(x))),
        ambHoraris: json["AMB_HORARIS"],
    );

    Map<String, dynamic> toJson() => {
        "ID_GRUPO": idGrupo,
        "ID_LINEA": idLinea,
        "ID_TRAYECTO": idTrayecto,
        "ID_TRAYECTO_SAE": idTrayectoSae,
        "DESC_TRAYECTO": descTrayecto,
        "DESC_REDUCIDA": descReducida,
        "PRINCIPAL": principal,
        "SENTIDO": sentiValues.reverse[sentido],
        "INI_TRAYECTO": iniTrayecto,
        "FIN_TRAYECTO": finTrayecto,
        "ID_TRAYECTO_CONCAT": idTrayectoConcat == null ? null : idTrayectoConcat,
        "TrayectosDet": List<dynamic>.from(trayectosDet.map((x) => x.toJson())),
        "AMB_HORARIS": ambHoraris,
    };
}

enum Senti { I, V }

final sentiValues = EnumValues({
    "I": Senti.I,
    "V": Senti.V
});

class TrayectosDet {
    TrayectosDet({
        this.parada,
        this.idGrupo,
        this.idLinea,
        this.idTrayecto,
        this.secuencia,
        this.idParada,
        this.nkmOrigen,
        this.subeBaja,
        this.id,
        this.sentit,
        this.sentitDif,
    });

    Parada parada;
    int idGrupo;
    int idLinea;
    int idTrayecto;
    int secuencia;
    int idParada;
    double nkmOrigen;
    int subeBaja;
    int id;
    Senti sentit;
    Senti sentitDif;

    factory TrayectosDet.fromJson(Map<String, dynamic> json) => TrayectosDet(
        parada: Parada.fromJson(json["Parada"]),
        idGrupo: json["ID_GRUPO"],
        idLinea: json["ID_LINEA"],
        idTrayecto: json["ID_TRAYECTO"],
        secuencia: json["SECUENCIA"],
        idParada: json["ID_PARADA"],
        nkmOrigen: json["NKM_ORIGEN"].toDouble(),
        subeBaja: json["SUBE_BAJA"],
        id: json["Id"] == null ? null : json["Id"],
        sentit: json["Sentit"] == null ? null : sentiValues.map[json["Sentit"]],
        sentitDif: json["sentitDif"] == null ? null : sentiValues.map[json["sentitDif"]],
    );

    Map<String, dynamic> toJson() => {
        "Parada": parada.toJson(),
        "ID_GRUPO": idGrupo,
        "ID_LINEA": idLinea,
        "ID_TRAYECTO": idTrayecto,
        "SECUENCIA": secuencia,
        "ID_PARADA": idParada,
        "NKM_ORIGEN": nkmOrigen,
        "SUBE_BAJA": subeBaja,
        "Id": id == null ? null : id,
        "Sentit": sentit == null ? null : sentiValues.reverse[sentit],
        "sentitDif": sentitDif == null ? null : sentiValues.reverse[sentitDif],
    };
}

class Parada {
    Parada({
        this.descParada,
        this.codParada,
        this.idGrupo,
        this.idParada,
        this.idMunicipio,
        this.municipio,
        this.explotadora,
        this.idZona,
        this.zona,
        this.idExplotadora,
        this.utmx,
        this.utmy,
        this.latitud,
        this.longitud,
        this.idSubzona,
        this.subzona,
        this.concesiones,
    });

    String descParada;
    int codParada;
    int idGrupo;
    int idParada;
    int idMunicipio;
    Municipio municipio;
    Explotadora explotadora;
    int idZona;
    dynamic zona;
    int idExplotadora;
    int utmx;
    int utmy;
    double latitud;
    double longitud;
    dynamic idSubzona;
    dynamic subzona;
    dynamic concesiones;

    factory Parada.fromJson(Map<String, dynamic> json) => Parada(
        descParada: json["DESC_PARADA"],
        codParada: json["COD_PARADA"],
        idGrupo: json["ID_GRUPO"],
        idParada: json["ID_PARADA"],
        idMunicipio: json["ID_MUNICIPIO"],
        municipio: municipioValues.map[json["MUNICIPIO"]],
        explotadora: explotadoraValues.map[json["EXPLOTADORA"]],
        idZona: json["ID_ZONA"],
        zona: json["ZONA"],
        idExplotadora: json["ID_EXPLOTADORA"],
        utmx: json["UTMX"],
        utmy: json["UTMY"],
        latitud: json["LATITUD"].toDouble(),
        longitud: json["LONGITUD"].toDouble(),
        idSubzona: json["ID_SUBZONA"],
        subzona: json["SUBZONA"],
        concesiones: json["CONCESIONES"],
    );

    Map<String, dynamic> toJson() => {
        "DESC_PARADA": descParada,
        "COD_PARADA": codParada,
        "ID_GRUPO": idGrupo,
        "ID_PARADA": idParada,
        "ID_MUNICIPIO": idMunicipio,
        "MUNICIPIO": municipioValues.reverse[municipio],
        "EXPLOTADORA": explotadoraValues.reverse[explotadora],
        "ID_ZONA": idZona,
        "ZONA": zona,
        "ID_EXPLOTADORA": idExplotadora,
        "UTMX": utmx,
        "UTMY": utmy,
        "LATITUD": latitud,
        "LONGITUD": longitud,
        "ID_SUBZONA": idSubzona,
        "SUBZONA": subzona,
        "CONCESIONES": concesiones,
    };
}

enum Explotadora { SARBUS }

final explotadoraValues = EnumValues({
    "SARBUS": Explotadora.SARBUS
});

enum Municipio { SANT_CUGAT_DEL_VALLS }

final municipioValues = EnumValues({
    "SANT CUGAT DEL VALLÈS": Municipio.SANT_CUGAT_DEL_VALLS
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
