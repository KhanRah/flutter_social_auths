import 'dart:async';

import 'package:flutter/material.dart';
import 'package:social_auths/bloc/bloc.dart';
import 'package:social_auths/screens/dashboardpage.dart';
import 'package:social_auths/screens/loginpage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  LoginBloc _loginBloc =LoginBloc();

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }


  void navigationPage() async {
//    print(_loginBloc.handleLogin());
    _loginBloc.handleLogin().listen((data){print('This is Data$data');
    if(data==null)
      {
        Navigator.of(context).pushReplacementNamed('/loginpage');

      }
    else
      {
        Navigator.of(context).pushReplacementNamed('/dashboard');
      }
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Welcome Screen'),
      ),
    );
  }
}
