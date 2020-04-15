import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_auths/bloc/bloc.dart';
import 'package:social_auths/screens/dashboardpage.dart';
import 'package:social_auths/services/authservice.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  LoginBloc _loginBloc = LoginBloc();

//  String phoneNo, verificationId, smsCode;
//
//  bool codeSent = false;

  @override
  void initState() {
    // TODO: implement initState
    _loginBloc.init();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _loginBloc.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
//              Padding(
//                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
//                  child: TextFormField(
//                    keyboardType: TextInputType.phone,
//                    decoration: InputDecoration(hintText: 'Enter phone number'),
//                    onChanged: (val) {
//                      setState(() {
//                        this.phoneNo = val;
//                      });
//                    },
//                  )),
//              codeSent ? Padding(
//                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
//                  child: TextFormField(
//                    keyboardType: TextInputType.phone,
//                    decoration: InputDecoration(hintText: 'Enter OTP'),
//                    onChanged: (val) {
//                      setState(() {
//                        this.smsCode = val;
//                      });
//                    },
//                  )) : Container(),
//              Padding(
//                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
//                  child: RaisedButton(
//                      child: Center(child: codeSent ? Text('Login'):Text('Verify')),
//                      onPressed: () {
//                        codeSent ? AuthService().signInWithOTP(smsCode, verificationId):verifyPhone(phoneNo);
//                      })),

              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: RaisedButton(
                      child: Center(child: Text('Google')),
                    onPressed: () {
                      _loginBloc.signInWithGoogle();
                    },
                      )
              ),
//              Padding(
//                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
//                  child: RaisedButton(
//                    child: Center(child: Text('FaceBook')),
//                    onPressed: ()async {
//                      await AuthService().faceBookLoginfsvf();
//                    },
//                  )
//              )
            ],
          )),
    );
  }



//  Future<void> verifyPhone(phoneNo) async {
//    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
//      AuthService().signIn(authResult);
//    };
//
//    final PhoneVerificationFailed verificationfailed =
//        (AuthException authException) {
//      print('${authException.message}');
//    };
//
//    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
//      this.verificationId = verId;
//      setState(() {
//        this.codeSent = true;
//      });
//    };
//
//    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
//      this.verificationId = verId;
//    };
//
//    await FirebaseAuth.instance.verifyPhoneNumber(
//        phoneNumber: phoneNo,
//        timeout: const Duration(seconds: 5),
//        verificationCompleted: verified,
//        verificationFailed: verificationfailed,
//        codeSent: smsSent,
//        codeAutoRetrievalTimeout: autoTimeout);
//  }
}