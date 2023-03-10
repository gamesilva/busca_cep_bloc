import 'package:busca_cep_bloc/bloc/home_bloc.dart';
import 'package:busca_cep_bloc/bloc/home_event.dart';
import 'package:busca_cep_bloc/bloc/home_state.dart';
import 'package:busca_cep_bloc/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(HomeStateLoading())
          ..add(HomeEventFetchCep(cepABuscar: '')),
        child: HomePage(),
      ),
    );
  }
}
