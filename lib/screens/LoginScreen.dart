import 'package:flutter/material.dart';
import 'package:simple_auth_flutter/simple_auth_flutter.dart';
import 'package:social_auths/bloc/login_bloc.dart';
import 'package:flutter/cupertino.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  LoginBloc _loginBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _loginBloc = LoginBloc();
    _loginBloc.init();
    _loginBloc.countryCode.sink.add(_loginBloc.countryCodes[0]);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top:50.0),
          child: Column(
            children: <Widget>[
              RaisedButton(onPressed: (){
                _loginBloc.signInWithGoogle();
               },child: Text('Google SignIn'),),
              RaisedButton(onPressed: (){
                _loginBloc.signInWithFaceBook();
              },child: Text('Facebook SignIn'),),
              RaisedButton(onPressed: (){
//                _loginBloc.login(_loginBloc.instagramApi);
              },child: Text('Insta SignIn'),),
              Container(
                height: 50.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]),
                    borderRadius:
                    BorderRadius.circular(6.0)
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(child: countryCode()),
                    Expanded(
                        flex: 4,
                        child: StreamBuilder(
                          stream: _loginBloc.streamPhone,
                          builder: (BuildContext context,AsyncSnapshot snapshot)
                          {
                            print('Number Screen Shot${snapshot.data}');
                            return TextField(
                              keyboardType:TextInputType.numberWithOptions(),
                              onChanged: _loginBloc.numberChange,
                              decoration: InputDecoration.collapsed(hintText: 'Enter your mobile number'),
                            );
                          },
                        )),
                  ],
                ),
              ),
              Container(
                  child: StreamBuilder(
                    stream: _loginBloc.streamOtp,
                    builder: (BuildContext context,AsyncSnapshot snapshot)
                    {
                      print('Number Screen Shot${snapshot.data}');
                      return TextField(
                        keyboardType:TextInputType.numberWithOptions(),
                        onChanged: _loginBloc.getOtp,
                        decoration: InputDecoration.collapsed(hintText: 'Enter your OTP'),
                      );
                    },
                  )),
              Row(children: <Widget>[
                RaisedButton(onPressed: (){
                  _loginBloc.signInWithPhone();
                },child: Text('Phone SignIn'),),
                RaisedButton(onPressed: (){
                  _loginBloc.enterOTP();
                },child: Text('OTP'),),
              ],)
            ],
          ),
        ),
      ),
    );
  }

  Widget countryCode() {
    return Padding(
      padding: const EdgeInsets.only(left:8.0),
      child: StreamBuilder(
        stream: _loginBloc.streamCode,
        initialData: _loginBloc.countryCodes[0],
        builder: (BuildContext context,AsyncSnapshot snapshot)
        {
          print('Data ${snapshot.data}');
          return DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              items: _loginBloc.countryCodes.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              value:snapshot.data ,
              onChanged: (val) {
                _loginBloc.countryCode.sink.add(val);
              },
            ),
          );
        },
      )
    );
  }
}

