import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sige_ie/places/data/place_request_model.dart';

class PlaceService {
  static Future<bool> register(PlaceRequestModel placeRequestModel) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/places/');
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(placeRequestModel.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        print("Registro bem-sucedido: $data");
        return true;
      } else {
        print("Falha no registro: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Erro ao tentar registrar: $e");
      return false;
    }
  }
}
