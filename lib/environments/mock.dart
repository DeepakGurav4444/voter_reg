import '../network_module/network/app_config.dart';

void startMOCK() {
  // SomeService.init(production: true);
  AppConfig.getInstance(
      appName: 'AgribidIndia',
      flavorName: 'MOCK',
      apiBaseUrl: "https://mock-api.in",
      );
}
