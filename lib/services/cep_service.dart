import 'dart:developer';

import 'package:busca_cep_bloc/models/cep_model.dart';
import 'package:busca_cep_bloc/services/webservice/ws.dart';

class CepService {
  WS ws = WS();

  Future<CepModel> getCepInfos(String cep) async {
    String url = 'https://viacep.com.br/ws/$cep/json/';
    Uri uri = Uri.parse(url);
    final response = await ws.makeGetRequest(uri);
    log('response: ${response.body}');
  }
}
