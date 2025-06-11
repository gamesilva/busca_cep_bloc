import 'dart:convert';
import 'package:busca_cep_bloc/services/webservice/ws.dart';

class CepService {
  WS ws = WS();

  Future<Map<String, dynamic>> getCepInfos(String cep) async {
    String url = 'https://viacep.com.br/ws/$cep/json/';
    Uri uri = Uri.parse(url);
    final response = await ws.makeGetRequest(uri);
    Map<String, dynamic> responseMap = json.decode(response.body);

    if (response?.statusCode != 200) {
      return {"invalidFormat": "O cep digitado tem um formato inválido!"};
    }

    if (response?.statusCode == 200 && responseMap.containsKey('erro')) {
      return {"absentCep": "Cep Inexistente!"};
    }

    return responseMap;
  }
}
