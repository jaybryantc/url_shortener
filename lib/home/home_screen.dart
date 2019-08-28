import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_shortener/home/home_form.dart';
import 'package:url_shortener/repositories/url_repository.dart';

import 'home.dart';

class HomeScreen extends StatelessWidget {
  static var homeScaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      body: BlocProvider<HomeBloc>(
        child: HomeForm(),
        builder: (context) => HomeBloc(URLRepository()),
      ),
    );
  }
}
