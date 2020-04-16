import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_auths/repository/base_repository.dart';
import 'package:flutter/material.dart';
import 'package:simple_auth/simple_auth.dart' as simpleAuth;

abstract class LoginRepository implements BaseRepository
{
  FirebaseAuth get fireBaseAuth;
  GoogleSignIn get googleSignIn;
  FirebaseUser get loggedInUser;
  FacebookLogin get faceBookLogin;
  Future signInWithGoogle();
  void signInWithInstagram();
  Future signInWithFaceBook();
  void login(simpleAuth.AuthenticatedApi api);
  void validateMobileNumber(String phone);
  Future signInWithOtp(String value);
}