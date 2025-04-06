import '../network_module/network/app_config.dart';

void startDEV() {
  // SomeService.init(production: true);
  AppConfig.getInstance(
      appName: 'AgribidIndia',
      flavorName: 'DEV',
      apiBaseUrl: "https://localhost:44375",
      );
}
