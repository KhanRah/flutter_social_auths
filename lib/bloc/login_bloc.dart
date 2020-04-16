import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:social_auths/bloc/baseBloc.dart';
import 'package:social_auths/repository/login_repository.dart';
import 'package:social_auths/repository/login_repository_impl.dart';
import 'package:simple_auth/simple_auth.dart' as simpleAuth;
class LoginBloc implements BaseBloc{


  LoginRepository _loginRepository;

  StreamController<FirebaseUser> loginDetails;
  Stream<FirebaseUser> get streamUser => loginDetails.stream;

  List<String> countryCodes = ['+61','+91'];

  BehaviorSubject<String> countryCode;
  Stream<String> get streamCode => countryCode.stream;

  BehaviorSubject<String> phoneNo;
  Stream<String> get streamPhone => phoneNo.stream;
  Function(String) get numberChange =>phoneNo.sink.add;

  BehaviorSubject<String> otp;
  Stream<String> get streamOtp => otp.stream;
  Function(String) get getOtp =>  otp.sink.add;

  String get numberValue => phoneNo.value;
  String get countryValue => countryCode.value;
  String get otpValue => otp.value;


  @override
  void dispose() {
    debugPrint('Dispose Called');
    loginDetails.close();
    countryCode.close();
    phoneNo.close();
    otp.close();
    // TODO: implement dispose
  }

  @override
  void init() {
     loginDetails = StreamController();
     countryCode = BehaviorSubject();
     phoneNo=BehaviorSubject();
     otp=BehaviorSubject();
    _loginRepository=LoginRepoImplementation();
  }

  void signInWithGoogle()async{
    FirebaseUser userDetails = await _loginRepository.signInWithGoogle();
    print('UserDetails ${userDetails.displayName}');
    loginDetails.sink.add(userDetails);
  }

  void signInWithFaceBook()async{
    FirebaseUser userDetails = await _loginRepository.signInWithFaceBook();
    print('UserDetails ${userDetails.displayName}');
    loginDetails.sink.add(userDetails);
  }

  login(simpleAuth.AuthenticatedApi api){
    _loginRepository.login(api);
  }

  void signInWithPhone()async
  {
    var phoneNumber = numberValue;
    var countryCode = countryValue;
    print('$countryCode, $phoneNumber');
    FirebaseUser userDetails=await _loginRepository.autoValidateMobileNumber(countryCode+phoneNumber);
    print('Phone Auth AUTO ${userDetails.phoneNumber}');

  }
  void enterOTP()async
  {
    var value = otpValue;
    print('otp value$value');
    FirebaseUser userDetails = await _loginRepository.signInWithOtp(value);
    print('Phone Auth with SMS ${userDetails.phoneNumber}');
  }

}