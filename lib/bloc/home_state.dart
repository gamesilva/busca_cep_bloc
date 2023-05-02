import 'package:flutter/material.dart';

class HomeState {}

class HomeStateLoading extends HomeState {}

class HomeStateError extends HomeState {
  final String errorMessage;

  HomeStateError({@required this.errorMessage});
}

class HomeStateSuccess extends HomeState {
  final List<Map<String, dynamic>> cep;

  HomeStateSuccess({@required this.cep});
}

class HomeStateNone extends HomeState {}
