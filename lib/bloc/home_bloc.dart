import 'package:busca_cep_bloc/bloc/home_event.dart';
import 'package:busca_cep_bloc/bloc/home_state.dart';
import 'package:busca_cep_bloc/models/cep_model.dart';
import 'package:busca_cep_bloc/services/cep_service.dart';
import 'package:busca_cep_bloc/utils/string_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  static const int MAX_CEP_LENGTH = 8;
  HomeBloc(HomeState initialState) : super(HomeStateLoading()) {
    on<HomeEventFetchCep>((event, emit) async {
      emit(HomeStateLoading());

      if (!StringUtils.stringTest(event.cepABuscar)) {
        emit(HomeStateError(errorMessage: 'Digite um cep!'));
      } else if (event.cepABuscar.length < MAX_CEP_LENGTH) {
        emit(HomeStateError(errorMessage: 'O cep deve conter 8 dígitos!'));
      } else {
        emit(await _fetchList(event.cepABuscar));
      }
    });
  }

  Future<HomeState> _fetchList(String cepAProcurar) async {
    Map<String, dynamic> cepMap = await CepService().getCepInfos(cepAProcurar);

    if (!cepMap.containsKey("Error")) {
      Cep cep = Cep.fromMap(cepMap);
      return HomeStateSuccess(cep: cep);
    }

    return HomeStateError(errorMessage: cepMap["Error"]);
  }
}
