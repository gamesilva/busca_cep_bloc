import 'package:busca_cep_bloc/bloc/home_bloc.dart';
import 'package:busca_cep_bloc/bloc/home_event.dart';
import 'package:busca_cep_bloc/bloc/home_state.dart';
import 'package:busca_cep_bloc/models/cep_model.dart';
import 'package:busca_cep_bloc/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    TextEditingController _controllerMensagem = TextEditingController();

    Cep cepToSave;

    return Scaffold(
      appBar: AppBar(
        title: Text('BuscaCep'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            iconSize: 28,
            icon: Icon(Icons.save),
            onPressed: () {
              if (cepToSave != null) {
                print("Eu vou começar o processo para salvar o CEP aqui!");
              }
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.grey[200],
            height: 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  CepFormField(controllerMensagem: _controllerMensagem),
                  SearchButton(
                    controllerMensagem: _controllerMensagem,
                    homeBloc: homeBloc,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              bloc: BlocProvider.of<HomeBloc>(context),
              builder: (context, state) {
                if (state is HomeStateError) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  );
                }
                if (state is HomeStateSuccess) {
                  cepToSave = state.cep;
                  return Center(
                    child: BuildListTile(cep: state.cep),
                  );
                }
                if (state is HomeStateLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return Center(child: Text('Digite o cep'));
              },
            ),
          ),
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
          child: TextField(
            maxLength: 8,
            maxLines: 1,
            cursorColor: Colors.black,
            controller: _controllerMensagem,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              counterText: "",
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              hintText: "Cep",
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
        if (!StringUtils.stringTest(_controllerMensagem.text)) {
          showSnackBar(context, "Digite um cep...");
        } else {
          homeBloc.add(HomeEventFetchCep(cepABuscar: _controllerMensagem.text));
        }
      },
      child: Icon(Icons.send),
    );
  }
}

class BuildListTile extends StatelessWidget {
  final Cep cep;
  const BuildListTile({Key key, this.cep}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 5,
              child: ListTile(
                title: Text('Cep'),
                subtitle: Text(cep.cep),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text('Logradouro'),
                subtitle: Text(cep.logradouro),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text('Complemento'),
                subtitle: Text(cep.complemento),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text('Bairro'),
                subtitle: Text(cep.bairro),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text('Localidade'),
                subtitle: Text(cep.localidade),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text('UF'),
                subtitle: Text(cep.uf),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text('IBGE'),
                subtitle: Text(cep.ibge),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text('DDD'),
                subtitle: Text(cep.ddd),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text('SIAFI'),
                subtitle: Text(cep.siafi),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text('GIA'),
                subtitle: Text(cep.gia),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

showSnackBar(BuildContext context, String mensagem) {
  SnackBar snackBar = SnackBar(
    content: Text(
      mensagem,
      style: TextStyle(fontSize: 18),
    ),
    behavior: SnackBarBehavior.floating,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
