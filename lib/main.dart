import 'package:flutter/material.dart';
import 'package:social_auths/bloc/bloc.dart';
import 'package:social_auths/screens/splashScreen.dart';
import 'package:social_auths/services/authservice.dart';
import 'package:social_auths/utils/routeHandler.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LoginBloc _bloc = LoginBloc();
@override
void initState() {
  // TODO: implement initState
  super.initState();
  _bloc.init();
}

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      home: _bloc.handleAuth(),
    );
  }
}