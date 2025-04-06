import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthData {
  static const String mobileToken = 'mobile_token';
  final storage = FlutterSecureStorage();

  Future<void> storeAuthData(String mobNum) async {
    await storage.write(key: mobileToken, value: mobNum);
  }

  Future<String?> getAuthData() async {
    return await storage.read(key: mobileToken);
  }

  Future<void> removeAuthData() async {
    await storage.delete(key: mobileToken);
  }

  Future<bool> isAuthExist() async {
    return (await storage.containsKey(key: mobileToken));
  }
}
