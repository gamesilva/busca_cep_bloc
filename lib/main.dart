import 'package:busca_cep_bloc/bloc/cep_cubit.dart';
import 'package:busca_cep_bloc/bloc/cep_state.dart';
import 'package:busca_cep_bloc/models/cep_model.dart';
import 'package:busca_cep_bloc/services/cep_service.dart';
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
      home: RepositoryProvider(
        create: (context) => CepService(),
        child: CepPage(
          title: 'BlocTest',
        ),
      ),
    );
  }
}

class CepPage extends StatelessWidget {
  final String title;
  const CepPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocProvider(
        create: (context) => CepCubit(
          cepService: context.read<CepService>(),
        ),
        child: CepView(),
      ),
    );
  }
}

class CepView extends StatelessWidget {
  const CepView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CepCubit>().state;
    switch (state.status) {
      case CepStatus.none:
        return CepVisualization(cep: null);
        break;
      case CepStatus.loading:
        return Center(child: CircularProgressIndicator());
        break;
      case CepStatus.error:
        return Center(child: Text('Ops! Something went wrong'));
        break;
      case CepStatus.success:
        return CepVisualization(cep: state.cep);
        break;
      default:
        return Container();
    }
  }
}

class CepVisualization extends StatelessWidget {
  final CepModel cep;
  const CepVisualization({Key key, this.cep}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              cep != null ? cep.logradouro : 'Digite o cep!',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CepCubit>().fetchCep('37501056'),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
