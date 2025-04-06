import 'package:voter_reg/modules/otp/models/otp_response_model.dart';

abstract class OTPApiRepository {
  /// Sends a login request to the authentication API with the provided [data].
  ///
  /// Returns a [UserModel] representing the user data if the login is successful.
  Future<OTPResponseModel?> sendOTP(Map<String, String> body);
  Future<OTPResponseModel?> rsendOTP(Map<String, String> body);
  Future<OTPResponseModel?> verifyOTP(Map<String, String> body);
}
