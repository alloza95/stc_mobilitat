class Line {
  int id; //identificador de la línia
  String code; //nom de la línia
  String description; //Resum del recurregut
  String color; //Color de la línia
  String textColor; //Color del text

  Line.fromJSON(Map<String, dynamic> jsonMap) :
    id = jsonMap['ID_LINEA'],
    code = jsonMap['COD_LINEA'],
    description = jsonMap['DESC_LINEA'],
    color = jsonMap['COLOR'],
    textColor = jsonMap['TEXT_COLOR'];
}