import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:url_shortener/home/home_screen.dart';

import 'home/home.dart';

class AppBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  BlocSupervisor.delegate = AppBlocDelegate();

  runApp(UrlShortenerApp());
}

class UrlShortenerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        primaryTextTheme: TextTheme(
          title: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

