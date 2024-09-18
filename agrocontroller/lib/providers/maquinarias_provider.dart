import 'dart:collection';

import 'package:http/http.dart' as http;
import 'dart:convert';

class MaquinariasProvider {
  final String apiURL =
      'https://controller.agrochofa.cl/api/sgm/maquinarias/public';

  Future<LinkedHashMap<String, dynamic>> fetchMaquinarias(
      int page, int pageSize, String search) async {
    var uri = Uri.parse(('$apiURL'));
    var respuesta = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(
          <String, dynamic>{
            'page': page,
            'pageSize': pageSize,
            'search': search,
          },
        ));
    return jsonDecode(respuesta.body);
  }
}
