import 'package:busca_cep_bloc/bloc/home_bloc.dart';
import 'package:busca_cep_bloc/bloc/home_event.dart';
import 'package:busca_cep_bloc/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    TextEditingController _controllerMensagem = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('BuscaCep'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              bloc: BlocProvider.of<HomeBloc>(context),
              builder: (context, state) {
                if (state is HomeStateError) {
                  return Center(child: Text(state.errorMessage));
                }
                if (state is HomeStateSuccess) {
                  return Center(child: Text(state.cep.toJson()));
                }
                if (state is HomeStateLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return Center(child: Text('Digite o cep'));
              },
            ),
          ),
          Row(
            children: <Widget>[
              CepFormField(controllerMensagem: _controllerMensagem),
              SearchButton(
                controllerMensagem: _controllerMensagem,
                homeBloc: homeBloc,
              )
            ],
          )
        ],
      ),
    );
  }
}

class CepFormField extends StatelessWidget {
  const CepFormField({
    Key key,
    @required TextEditingController controllerMensagem,
  })  : _controllerMensagem = controllerMensagem,
        super(key: key);

  final TextEditingController _controllerMensagem;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 6),
            child: TextField(
              maxLines: 2,
              scrollPadding: EdgeInsets.only(
                top: 0,
              ),
              cursorColor: Colors.black,
              controller: _controllerMensagem,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: "Cep",
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({
    Key key,
    @required TextEditingController controllerMensagem,
    @required this.homeBloc,
  })  : _controllerMensagem = controllerMensagem,
        super(key: key);

  final TextEditingController _controllerMensagem;
  final HomeBloc homeBloc;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.blue,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
      onPressed: () async {
        homeBloc.add(HomeEventFetchCep(cepABuscar: _controllerMensagem.text));
        _controllerMensagem.clear();
      },
      child: Icon(Icons.send),
    );
  }
}
