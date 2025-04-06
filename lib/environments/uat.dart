import '../network_module/network/app_config.dart';

void startUAT() {
  // SomeService.init(production: true);
  AppConfig.getInstance(
      appName: 'AgribidIndia',
      flavorName: 'UAT',
      apiBaseUrl: "https://dev-agribid-api.ifelsesolutions.in",
      );
}
