
import 'package:flutter/material.dart';
import 'package:social_auths/screens/dashboardpage.dart';
import 'package:social_auths/screens/loginpage.dart';
import 'package:social_auths/screens/splashScreen.dart';

const String splashScreen = "/";
const String loginScreen = "/loginpage";
const String dashBoard = "/dashboard";

class RouteGenerator
{
  static Route<dynamic> generateRoute(RouteSettings settings)
  {
    final  args = settings.arguments;
    print('arguments passed $args');
    switch (settings.name)
    {
      case splashScreen:
        {
          return MaterialPageRoute(builder: (_)=>SplashScreen());
        }
      case loginScreen:
        {
          return MaterialPageRoute(builder: (_)=>LoginPage());
        }
      case dashBoard:
        {
          return MaterialPageRoute(builder: (_)=>DashboardPage());
        }
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}