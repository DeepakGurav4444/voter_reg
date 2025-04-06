import '../network_module/network/app_config.dart';

void startPROD() {
  // SomeService.init(production: true);
 AppConfig.getInstance(
      appName: 'AgribidIndia',
      flavorName: 'PROD',
      apiBaseUrl: "https://dev-agribid-api.ifelsesolutions.in",
      
      );
}
