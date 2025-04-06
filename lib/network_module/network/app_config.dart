import 'package:flutter/foundation.dart';

class AppConfig {
  final String? appName;
  final String? flavorName;
  final String? apiBaseUrl;

  AppConfig(
      {this.appName,
      this.flavorName,
      this.apiBaseUrl});

  static AppConfig? _instance;

  static AppConfig getInstance(
      {appName,
      flavorName,
      apiBaseUrl}) {
    if (_instance == null) {
      _instance = AppConfig(
          appName: appName,
          flavorName: flavorName,
          apiBaseUrl: apiBaseUrl);
      if (kDebugMode) {
        print('APP CONFIGURED FOR: $flavorName');
      }
      return _instance!;
    }
    return _instance!;
  }
}
