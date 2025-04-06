import 'package:voter_reg/modules/home/repository/home_repository.dart';
import 'package:voter_reg/network_module/network/app_config.dart';
import 'package:voter_reg/utils/services/auth_data.dart';
import '../modules/otp/repository/otp_repository.dart';
import '../utils/services/local_data.dart';
import 'dependency_injection.dart';

// GetIt is a package used for service locator or to manage dependency injection
GetIt getIt = GetIt.instance;

class ServiceLocator {
  void servicesLocator() {
    final GetIt locator = GetIt.instance;
    getIt.registerLazySingleton<LocalData>(() => LocalData());
    getIt.registerLazySingleton<AuthData>(() => AuthData());
    if (AppConfig.getInstance().flavorName == 'MOCK') {
      getIt.registerLazySingleton<VoterRegApiRepository>(
          () => VoterRegMockApiRepository(localData: locator<LocalData>()));
      getIt.registerLazySingleton<OTPApiRepository>(() =>
          OTPMockApiRepository()); // Registering AuthHttpApiRepository as a lazy singleton for AuthApiRepository
      getIt.registerLazySingleton<HomeApiRepository>(
          () => HomeMockApiRepository(localData: locator<LocalData>()));
    } else {
      getIt.registerLazySingleton<VoterRegApiRepository>(
          () => VoterRegHttpApiRepository());
      getIt.registerLazySingleton<OTPApiRepository>(
          () => OTPHttpApiRepository());
      getIt.registerLazySingleton<HomeApiRepository>(
          () => HomeHttpApiRepository());
    }
  }
}
