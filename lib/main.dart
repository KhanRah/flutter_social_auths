import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_auth_flutter/simple_auth_flutter.dart';
import 'package:social_auths/bloc/login_bloc.dart';
import 'package:social_auths/screens/LoginScreen.dart';
import 'package:social_auths/screens/dashboardpage.dart';
import 'package:social_auths/services/authservice.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_auths/repository/base_repository.dart';
import 'package:social_auths/repository/login_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart'as http;
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  LoginBloc _loginBloc;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginBloc = LoginBloc();
    _loginBloc.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<FirebaseUser>(
        stream: _loginBloc.streamUser,
          builder: (BuildContext context,AsyncSnapshot<FirebaseUser> snapshot)
        {
          debugPrint('snapShot${snapshot.data}');
          if(snapshot.data!=null)
            {
              return DashboardPage();
            }
          else
            {
              return LoginScreen();
            }
      })
    );
  }
}
