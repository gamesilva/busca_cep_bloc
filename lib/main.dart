import 'dart:developer';

import 'package:busca_cep_bloc/counter.dart';
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
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<CounterCubit>(
            create: (BuildContext context) => CounterCubit(),
          )
        ],
        child: MyHomePage(
          title: 'BlocTest',
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  getCep() async {
    await CepService().getCepInfos('37501056');
  }

  @override
  Widget build(BuildContext context) {
    final counter = context.read<CounterCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<CounterCubit, int>(
        builder: (context, count) {
          log('-- builder: $count');
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$count',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () => counter.increment(),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () => counter.decrement(),
            tooltip: 'Decrement',
            child: Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
