import 'package:busca_cep_bloc/models/cep_model.dart';
import 'package:flutter/material.dart';

class HomeState {}

class HomeStateLoading extends HomeState {}

class HomeStateError extends HomeState {
  final String errorMessage;

  HomeStateError({@required this.errorMessage});
}

class HomeStateSuccess extends HomeState {
  final Cep cep;

  HomeStateSuccess({@required this.cep});
}

class HomeStateNone extends HomeState {}