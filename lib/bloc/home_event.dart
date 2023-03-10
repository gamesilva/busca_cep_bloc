import 'package:flutter/foundation.dart';

class HomeEvent {}

class HomeEventFetchCep extends HomeEvent {
  final String cepABuscar;

  HomeEventFetchCep({@required this.cepABuscar});
}

class HomeEventFetchListWithError extends HomeEvent {}
