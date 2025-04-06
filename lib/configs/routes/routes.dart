import 'package:flutter/material.dart';
import 'package:voter_reg/modules/home/screen/home_screen.dart';
import 'package:voter_reg/modules/login/view/screens/login_screen.dart';
import 'package:voter_reg/modules/splash/view/screens/splash_screen.dart';
import 'package:voter_reg/modules/voter_reg/view/screens/voter_reg_screen.dart';
import 'routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case RoutesName.splash:
      //   return MaterialPageRoute(builder: (BuildContext context) => const SplashView());

      // case RoutesName.home:
      //   return MaterialPageRoute(builder: (BuildContext context) => const MoviesScreen());

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());

      case RoutesName.voterReg:
        return MaterialPageRoute(
            builder: (BuildContext context) => const VoterRegScreen(),settings: settings);
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('Something went wrong.'),
            ),
          );
        });
    }
  }
}
