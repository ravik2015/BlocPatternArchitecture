import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockfarm/blocs/SimpleBlocDelegate.dart';
import 'package:rockfarm/blocs/CounterBloc.dart';
import 'package:rockfarm/blocs/ThemeBloc.dart';
import 'package:rockfarm/pages/UserPage.dart';
import 'package:rockfarm/pages/login_screen.dart';
import 'package:rockfarm/pages/UserPage.dart';

void main() {
  // BlocSupervisor.delegate = SimpleBlocDelegate();
  // runApp(App());

  runApp(MaterialApp(
    initialRoute: '/',
    routes: <String, WidgetBuilder>{
      '/': (context) => LoginScreen(),
      '/second': (context) => UserPage(),
    },
  ));
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  final CounterBloc _counterBloc = CounterBloc();
  final ThemeBloc _themeBloc = ThemeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<CounterBloc>(bloc: _counterBloc),
        BlocProvider<ThemeBloc>(bloc: _themeBloc)
      ],
      child: BlocBuilder(
        bloc: _themeBloc,
        builder: (_, ThemeData theme) {
          return MaterialApp(
            title: 'Flutter Demo',
            home: UserPage(),
            theme: theme,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _counterBloc.dispose();
    _themeBloc.dispose();
    super.dispose();
  }
}
