import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/line.dart';

Future<Stream<Line>> getLines() async {
  final String url = 'https://santqbus.santcugat.cat/consultamv.php?q=GetListaLineas';

  final client = new http.Client();
  final streamedRest = await client.send(
      http.Request('get', Uri.parse(url))
  );

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Line.fromJSON(data));
}