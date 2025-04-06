import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voter_reg/configs/routes/routes_name.dart';
import 'package:voter_reg/environments/dev.dart';
import 'package:voter_reg/environments/mock.dart';
import 'package:voter_reg/environments/prod.dart';
import 'package:voter_reg/environments/uat.dart';
import 'dependency_injection/locator.dart';

import 'configs/routes/routes.dart';
import 'network_module/network/my_http_ovrrides.dart';

ServiceLocator dependencyInjector = ServiceLocator();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await const MethodChannel('flavor')
      .invokeMethod<String>('getFlavor')
      .then((String? flavor) {
    if (kDebugMode) {
      print('STARTED WITH FLAVOR $flavor');
    }
    if (flavor == 'PROD') {
      startPROD();
    } else if (flavor == 'UAT') {
      startUAT();
    } else if (flavor == "DEV") {
      startDEV();
    } else if (flavor == "MOCK") {
      startMOCK();
    }
  }).catchError((error) {
    if (kDebugMode) {
      debugPrint(error);
    }
    if (kDebugMode) {
      print('FAILED TO LOAD FLAVOR');
    }
  });
  dependencyInjector
      .servicesLocator(); // Initializing service locator for dependency injection
  // if (Platform.isAndroid) {
  //   final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  //   dynamic info;
  //   info = await deviceInfoPlugin.androidInfo;
  //   (info.version.sdkInt) <= 24 ? HttpOverrides.global = MyHttpOverrides() : "";
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.5),
            ),
            isDense: true),
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      // Setting theme mode to dark
      // theme: lightTheme,
      // darkTheme: darkTheme,
      onGenerateRoute: Routes.generateRoute,
      initialRoute: RoutesName.splash,
      debugShowCheckedModeBanner: false,
    );
  }
}
