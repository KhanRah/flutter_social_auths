import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:social_auths/bloc/base_bloc.dart';
import 'package:social_auths/screens/dashboardpage.dart';
import 'package:social_auths/screens/loginpage.dart';

class LoginBloc extends BaseBloc {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  final BehaviorSubject<FirebaseUser> _google = BehaviorSubject<FirebaseUser>();

  Stream<FirebaseUser> get googleAccount => _google.stream;

  handleAuth() {
    print('Handle Login${_auth.onAuthStateChanged}');
    return StreamBuilder(
        stream: _auth.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            print('SnapShot in IF $snapshot} ${snapshot.data}');
            return DashboardPage();
          } else {
            print('SnapShot in else ${snapshot.data}');
            return LoginPage();
          }
        });
  }


  Stream handleLogin()
  {
    return _auth.onAuthStateChanged;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _google.close();
  }

  @override
  void init() {
    // TODO: implement init
  }



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
    _google.sink.add(user);
    return 'signInWithGoogle succeeded: $user';
  }

  void signOutGoogle() async{
    await _auth.signOut();
    await googleSignIn.signOut();
    print("User Sign Out");
  }

  myFunc()
  {
    final subscription = _google.listen((ondata){
      return ondata;
    });
  }


//  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly']);
//
//  // StreamController
//  final BehaviorSubject<GoogleSignInAccount> _google = BehaviorSubject<GoogleSignInAccount>();
//
//  // Streams
//
//  Stream<GoogleSignInAccount> get googleAccount => _google.stream;
//
//  sigInGoogle() async {
//    _googleSignIn.signIn().then((GoogleSignInAccount account) {
//      _google.sink.add(account);
//    });
//  }
//
//  signOutGoogle() async {
//    _googleSignIn.signOut().then(_google.sink.add);
//  }
//
//  dispose() {
//    _google.close();
//  }
}