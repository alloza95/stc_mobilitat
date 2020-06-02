// To parse this JSON data, do
//
//     final parada = paradaFromJson(jsonString);

import 'dart:convert';

List<BusStop> busStopFromJson(String str) => List<BusStop>.from(json.decode(str).map((x) => BusStop.fromJson(x)));

String busStopToJson(List<BusStop> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BusStop {
    BusStop({
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

    ParadaClass parada;
    int idGrupo;
    int idLinea;
    int idTrayecto;
    int secuencia;
    int idParada;
    double nkmOrigen;
    int subeBaja;
    int id;
    Sentit sentit;
    Sentit sentitDif;

    factory BusStop.fromJson(Map<String, dynamic> json) => BusStop(
        parada: ParadaClass.fromJson(json["Parada"]),
        idGrupo: json["ID_GRUPO"],
        idLinea: json["ID_LINEA"],
        idTrayecto: json["ID_TRAYECTO"],
        secuencia: json["SECUENCIA"],
        idParada: json["ID_PARADA"],
        nkmOrigen: json["NKM_ORIGEN"].toDouble(),
        subeBaja: json["SUBE_BAJA"],
        id: json["Id"],
        sentit: sentitValues.map[json["Sentit"]],
        sentitDif: json["sentitDif"] == null ? null : sentitValues.map[json["sentitDif"]],
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
        "Id": id,
        "Sentit": sentitValues.reverse[sentit],
        "sentitDif": sentitDif == null ? null : sentitValues.reverse[sentitDif],
    };
}

class ParadaClass {
    ParadaClass({
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

    factory ParadaClass.fromJson(Map<String, dynamic> json) => ParadaClass(
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

enum Municipio { SANT_CUGAT_DEL_VALLS, CERDANYOLA_DEL_VALLES, VALLDOREIX, BARCELONA, TERRASSA, BADIA_DEL_VALLS, SABADELL, RUB, RIPOLLET, RUBI, MONTCADA_I_REIXAC, BARBERA_DEL_VALLES, SANT_QUIRZE_DEL_VALLS, SANT_QUIRZE_DEL_VALLES }

final municipioValues = EnumValues({
    "BADIA DEL VALLÈS": Municipio.BADIA_DEL_VALLS,
    "BARBERA DEL VALLES": Municipio.BARBERA_DEL_VALLES,
    "BARCELONA": Municipio.BARCELONA,
    "CERDANYOLA DEL VALLES": Municipio.CERDANYOLA_DEL_VALLES,
    "MONTCADA I REIXAC": Municipio.MONTCADA_I_REIXAC,
    "RIPOLLET": Municipio.RIPOLLET,
    "RUBÍ": Municipio.RUB,
    "RUBI": Municipio.RUBI,
    "SABADELL": Municipio.SABADELL,
    "SANT CUGAT DEL VALLÈS": Municipio.SANT_CUGAT_DEL_VALLS,
    "SANT QUIRZE DEL VALLES": Municipio.SANT_QUIRZE_DEL_VALLES,
    "SANT QUIRZE DEL VALLÈS": Municipio.SANT_QUIRZE_DEL_VALLS,
    "TERRASSA": Municipio.TERRASSA,
    "VALLDOREIX": Municipio.VALLDOREIX
});

enum Sentit { V, I }

final sentitValues = EnumValues({
    "I": Sentit.I,
    "V": Sentit.V
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
