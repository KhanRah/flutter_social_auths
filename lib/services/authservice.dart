//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//import 'package:social_auths/screens/dashboardpage.dart';
//import 'package:social_auths/screens/loginpage.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
//class AuthService {
//  //Handles Auth
//  handleAuth() {
//    return StreamBuilder(
//        stream: FirebaseAuth.instance.onAuthStateChanged,
//        builder: (BuildContext context, snapshot) {
//          if (snapshot.hasData) {
//            return DashboardPage();
//          } else {
//            return LoginPage();
//          }
//        });
//  }
//
//
//  //Sign out
//  signOut() {
//    FirebaseAuth.instance.signOut();
//  }
//
//  //SignIn
//  signIn(AuthCredential authCreds) {
//    FirebaseAuth.instance.signInWithCredential(authCreds);
//  }
//
//  signInWithOTP(smsCode, verId) {
//    AuthCredential authCreds = PhoneAuthProvider.getCredential(
//        verificationId: verId, smsCode: smsCode);
//    signIn(authCreds);
//  }
//  final FirebaseAuth _auth = FirebaseAuth.instance;
//
//  final GoogleSignIn googleSignIn = GoogleSignIn();
//
//  Future<String> signInWithGoogle() async {
//
//
//    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
//    final GoogleSignInAuthentication googleSignInAuthentication =
//    await googleSignInAccount.authentication;
//
//    final AuthCredential credential = GoogleAuthProvider.getCredential(
//      accessToken: googleSignInAuthentication.accessToken,
//      idToken: googleSignInAuthentication.idToken,
//    );
//
//    final AuthResult authResult = await _auth.signInWithCredential(credential);
//    final FirebaseUser user = authResult.user;
//
//    print('result ${user.displayName},${user.email},${user.photoUrl}');
//
//    assert(!user.isAnonymous);
//    assert(await user.getIdToken() != null);
//
//    final FirebaseUser currentUser = await _auth.currentUser();
//    assert(user.uid == currentUser.uid);
//
//    return 'signInWithGoogle succeeded: $user';
//  }
//
//  void signOutGoogle() async{
//    await googleSignIn.signOut();
//    print("User Sign Out");
//  }
//
//}