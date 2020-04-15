import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_auths/screens/dashboardpage.dart';
import 'package:social_auths/screens/loginpage.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
class AuthService {
  //Handles Auth
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            print('SnapShot in if$snapshot ${snapshot.data}');
            return DashboardPage();
          } else {
            print('SnapShot in else$snapshot ${snapshot.data}');
            return LoginPage();
          }
        });
  }


  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //SignIn
  signIn(AuthCredential authCreds)async {
    final AuthResult authResult =await FirebaseAuth.instance.signInWithCredential(authCreds);
    final FirebaseUser user = authResult.user;
    print('result ${user.displayName},${user.email},${user.photoUrl},${user.uid},');
  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {


    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    print('result ${user.displayName},${user.email},${user.photoUrl}');

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }

  void signOutGoogle() async{
    await _auth.signOut();
    await googleSignIn.signOut();
    print("User Sign Out");
  }



  FacebookLogin facebookLogin = FacebookLogin();
  Future<FacebookLoginResult> _handleFBSignIn() async {

    FacebookLoginResult facebookLoginResult =
    await facebookLogin.logInWithReadPermissions(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.cancelledByUser:
        print("Cancelled");
        break;
      case FacebookLoginStatus.error:
        print("error");
        break;
      case FacebookLoginStatus.loggedIn:
        print("Logged In");
        break;
    }
    return facebookLoginResult;
  }
  Future faceBookLoginfsvf()async
  {
    FacebookLoginResult facebookLoginResult = await _handleFBSignIn();
    final accessToken = facebookLoginResult.accessToken.token;
    if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
      final facebookAuthCred =
      FacebookAuthProvider.getCredential(accessToken: accessToken);
      final user = await _auth.signInWithCredential(facebookAuthCred);
      print("User :  + ${user.user.displayName}");
      return facebookLoginResult;
    }
  }
  Future<void> fbsignOut() async {
    await facebookLogin.logOut();
    await _auth.signOut();
  }

}