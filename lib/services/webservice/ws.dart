import 'package:busca_cep_bloc/models/cep_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class WS {
  Future<Response> makeGetRequest(Uri url) async {
    return await http.get(url);
  }
}
