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
import 'package:simple_auth/simple_auth.dart' as simpleAuth;

class LoginRepoImplementation implements LoginRepository{


  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static FirebaseUser _firebaseUser;
  String verificationId,smsId;
  FacebookLogin _facebookLogin = FacebookLogin();
  @override
  FirebaseAuth get fireBaseAuth => _firebaseAuth;

  @override
  GoogleSignIn get googleSignIn => _googleSignIn;

  @override
  FirebaseUser get loggedInUser => _firebaseUser;

  @override
  FacebookLogin get faceBookLogin => _facebookLogin;

  Future<FacebookLoginResult> _handleFBSignIn() async {

    FacebookLoginResult facebookLoginResult =
    await faceBookLogin.logInWithReadPermissions(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.cancelledByUser:
        debugPrint("Cancelled");
        break;
      case FacebookLoginStatus.error:
        debugPrint("error");
        break;
      case FacebookLoginStatus.loggedIn:
        debugPrint("Logged In");
        break;
    }
    return facebookLoginResult;
  }
  @override
  Future signInWithFaceBook()async {
    FacebookLoginResult facebookLoginResult = await _handleFBSignIn();
    final accessToken = facebookLoginResult.accessToken.token;
    if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
      final facebookAuthCred = FacebookAuthProvider.getCredential(accessToken: accessToken);
      final user = await FirebaseAuth.instance.signInWithCredential(facebookAuthCred);
      print("User :  + ${user.user.displayName}");
    }
    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    return currentUser;
  }

  @override
  Future<FirebaseUser> signInWithGoogle()async {

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _firebaseAuth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    debugPrint('result ${user.displayName},${user.email},${user.photoUrl}');

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    assert(user.uid == currentUser.uid);
    return currentUser;
  }

  @override
  void signInWithInstagram() {
    // TODO: implement signInWithInstagram
  }

  @override
  void login(simpleAuth.AuthenticatedApi api)async {
    try {
      var success = await api.authenticate();
      print("Logged in success: $success");
    } catch (e) {
      print("error ${e.toString()}");
    }
  }

  @override
  Future<FirebaseUser> autoValidateMobileNumber(String phone)async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      _firebaseAuth.signInWithCredential(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      debugPrint('Sms is SENT');
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 30),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    print('Current User$currentUser');
    return currentUser;
  }

  @override
  Future<FirebaseUser> signInWithOtp(String value)async {
    print('verId$verificationId, otp $value',);
    if(verificationId!=null)
      {
        AuthCredential authCreds = PhoneAuthProvider.getCredential(
            verificationId: verificationId, smsCode: value);
        await _firebaseAuth.signInWithCredential(authCreds);

      }
    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    print('Current User$currentUser');
    return currentUser;
  }

}
