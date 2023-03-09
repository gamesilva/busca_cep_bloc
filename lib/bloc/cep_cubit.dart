import 'package:busca_cep_bloc/bloc/cep_state.dart';
import 'package:busca_cep_bloc/models/cep_model.dart';
import 'package:busca_cep_bloc/services/cep_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CepCubit extends Cubit<CepState> {
  final CepService cepService;

  CepCubit({@required this.cepService}) : super(CepState.none());

  fetchCep(String cepToFind) async {
    try {
      emit(CepState.loading());
      CepModel cep = await cepService.getCepInfos(cepToFind);
      emit(CepState.success(cep));
    } catch (e) {
      emit(CepState.error());
    }
  }
}
