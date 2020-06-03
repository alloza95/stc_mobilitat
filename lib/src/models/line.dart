// To parse this JSON data, do
//
//     final line = lineFromJson(jsonString);

import 'dart:convert';

List<Line> lineFromJson(String str) => List<Line>.from(json.decode(str).map((x) => Line.fromJson(x)));

String lineToJson(List<Line> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Line {
    Line({
        this.idZona,
        this.idSubzona,
        this.idGrupo,
        this.idLinea,
        this.idLineaSae,
        this.idExplotadora,
        this.idUnidfisc,
        this.idConcesion,
        this.codLinea,
        this.codLineaWeb,
        this.descLinea,
        this.descReducida,
        this.tipo,
        this.color,
        this.textColor,
        this.tiempoAviso,
        this.forma,
        this.explotadora,
        this.adaptada,
        this.treal,
        this.circular,
        this.trayectos,
        this.id,
        this.index,
    });

    int idZona;
    int idSubzona;
    int idGrupo;
    int idLinea;
    int idLineaSae;
    int idExplotadora;
    int idUnidfisc;
    int idConcesion;
    String codLinea;
    String codLineaWeb;
    String descLinea;
    String descReducida;
    Tipo tipo;
    String color;
    String textColor;
    int tiempoAviso;
    Forma forma;
    Explotadora explotadora;
    Adaptada adaptada;
    Adaptada treal;
    Adaptada circular;
    dynamic trayectos;
    int id;
    int index;

    factory Line.fromJson(Map<String, dynamic> json) => Line(
        idZona: json["ID_ZONA"],
        idSubzona: json["ID_SUBZONA"],
        idGrupo: json["ID_GRUPO"],
        idLinea: json["ID_LINEA"],
        idLineaSae: json["ID_LINEA_SAE"] == null ? null : json["ID_LINEA_SAE"],
        idExplotadora: json["ID_EXPLOTADORA"],
        idUnidfisc: json["ID_UNIDFISC"],
        idConcesion: json["ID_CONCESION"],
        codLinea: json["COD_LINEA"],
        codLineaWeb: json["COD_LINEA_WEB"],
        descLinea: json["DESC_LINEA"],
        descReducida: json["DESC_REDUCIDA"],
        tipo: tipoValues.map[json["TIPO"]],
        color: json["COLOR"],
        textColor: json["TEXT_COLOR"],
        tiempoAviso: json["TIEMPO_AVISO"],
        forma: formaValues.map[json["FORMA"]],
        explotadora: explotadoraValues.map[json["EXPLOTADORA"]],
        adaptada: adaptadaValues.map[json["ADAPTADA"]],
        treal: adaptadaValues.map[json["TREAL"]],
        circular: adaptadaValues.map[json["CIRCULAR"]],
        trayectos: json["Trayectos"],
        id: json["id"],
        index: json["index"],
    );

    Map<String, dynamic> toJson() => {
        "ID_ZONA": idZona,
        "ID_SUBZONA": idSubzona,
        "ID_GRUPO": idGrupo,
        "ID_LINEA": idLinea,
        "ID_LINEA_SAE": idLineaSae == null ? null : idLineaSae,
        "ID_EXPLOTADORA": idExplotadora,
        "ID_UNIDFISC": idUnidfisc,
        "ID_CONCESION": idConcesion,
        "COD_LINEA": codLinea,
        "COD_LINEA_WEB": codLineaWeb,
        "DESC_LINEA": descLinea,
        "DESC_REDUCIDA": descReducida,
        "TIPO": tipoValues.reverse[tipo],
        "COLOR": color,
        "TEXT_COLOR": textColor,
        "TIEMPO_AVISO": tiempoAviso,
        "FORMA": formaValues.reverse[forma],
        "EXPLOTADORA": explotadoraValues.reverse[explotadora],
        "ADAPTADA": adaptadaValues.reverse[adaptada],
        "TREAL": adaptadaValues.reverse[treal],
        "CIRCULAR": adaptadaValues.reverse[circular],
        "Trayectos": trayectos,
        "id": id,
        "index": index,
    };
}

enum Adaptada { S, N }

final adaptadaValues = EnumValues({
    "N": Adaptada.N,
    "S": Adaptada.S
});

enum Explotadora { SARBUS }

final explotadoraValues = EnumValues({
    "SARBUS": Explotadora.SARBUS
});

enum Forma { REDONDO }

final formaValues = EnumValues({
    "redondo": Forma.REDONDO
});

enum Tipo { U, I }

final tipoValues = EnumValues({
    "I": Tipo.I,
    "U": Tipo.U
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
