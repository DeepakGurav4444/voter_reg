import 'package:flutter/material.dart';
import 'package:voter_reg/modules/splash/blocs/splash_bloc.dart';
import '../../../../dependency_injection/locator.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashBloc splashBloc;

  @override
  void initState() {
    splashBloc = SplashBloc(context: context, authData: getIt());
    splashBloc.add(SplashInitialEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}