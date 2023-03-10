import 'package:busca_cep_bloc/bloc/home_event.dart';
import 'package:busca_cep_bloc/bloc/home_state.dart';
import 'package:busca_cep_bloc/models/cep_model.dart';
import 'package:busca_cep_bloc/services/cep_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(HomeState initialState) : super(HomeStateLoading()) {
    on<HomeEventFetchCep>((event, emit) async {
      if (event.cepABuscar != null && event.cepABuscar.length > 0) {
        emit(HomeStateLoading());
        emit(await _fetchList(event.cepABuscar));
      } else {
        emit(HomeStateError(errorMessage: 'Digite um cep'));
      }
    });
  }

  Future<HomeState> _fetchList(String cepAProcurar) async {
    Cep cep = await CepService().getCepInfos(cepAProcurar);

    return HomeStateSuccess(cep: cep);
  }
}
