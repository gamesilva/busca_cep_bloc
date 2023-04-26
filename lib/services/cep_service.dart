import 'dart:convert';
import 'package:busca_cep_bloc/services/webservice/ws.dart';

class CepService {
  WS ws = WS();
  Map<String, dynamic> mapErrorResponse = {
    "Error": "Erro ao coletar CEP",
  };

  Future<Map<String, dynamic>> getCepInfos(String cep) async {
    String url = 'https://viacep.com.br/ws/$cep/json/';
    Uri uri = Uri.parse(url);
    final response = await ws.makeGetRequest(uri);

    if (response?.statusCode != 200) {
      return mapErrorResponse;
    }

    return json.decode(response.body);
  }
}
