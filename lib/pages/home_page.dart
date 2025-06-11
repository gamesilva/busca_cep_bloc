import 'package:busca_cep_bloc/bloc/home_bloc.dart';
import 'package:busca_cep_bloc/bloc/home_event.dart';
import 'package:busca_cep_bloc/bloc/home_state.dart';
import 'package:busca_cep_bloc/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    TextEditingController _controllerMensagem = TextEditingController();

    List<Map<String, dynamic>> cepToSave;

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
                    child: Wrap(
                      children: [
                        Text(
                          state.errorMessage,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ],
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
  final List<Map<String, dynamic>> cep;
  const BuildListTile({Key key, this.cep}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cep.length,
                itemBuilder: (context, index) {
                  return _buildCardInfoCep(
                    cep[index].entries.first.key,
                    cep[index].entries.first.value,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardInfoCep(String title, String subtitle) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: Text(
          StringUtils.stringTest(title)
              ? formatCepTitle(title)
              : 'Sem Informação',
        ),
        subtitle: Text(
          StringUtils.stringTest(subtitle) ? subtitle : 'Sem Informação',
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

String formatCepTitle(String value) {
  if (value.length > 5) {
    return StringUtils.captalize(value);
  } else if (value == 'cep') {
    return StringUtils.captalize(value);
  } else {
    return value.toUpperCase();
  }
}
