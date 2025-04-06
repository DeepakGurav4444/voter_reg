import 'package:voter_reg/modules/otp/models/otp_response_model.dart';
import 'package:voter_reg/modules/otp/repository/otp_api_repository.dart';

class OTPMockApiRepository implements OTPApiRepository {
  @override
  Future<OTPResponseModel?> rsendOTP(Map<String, String> body) async {
    await Future.delayed(Duration(seconds: 2));
    var responseData = {
      "data": 1,
      "message": "OTP sent successfully.",
      "validationMessages": [""],
      "isSuccessful": true,
      "isBusinessError": false,
      "isSystemError": false,
      "systemErrorMessage": "null",
      "businessErrorMessage": "null"
    };
    return OTPResponseModel.fromJson(responseData);
  }

  @override
  Future<OTPResponseModel?> sendOTP(Map<String, String> body) async {
    await Future.delayed(Duration(seconds: 2));
    var responseData = {
      "data": 1,
      "message": "OTP sent successfully.",
      "validationMessages": [""],
      "isSuccessful": true,
      "isBusinessError": false,
      "isSystemError": false,
      "systemErrorMessage": "null",
      "businessErrorMessage": "null"
    };
    return OTPResponseModel.fromJson(responseData);
  }

  @override
  Future<OTPResponseModel?> verifyOTP(Map<String, String> body) async {
    await Future.delayed(Duration(seconds: 2));
    var responseData = {
      "data": 1,
      "message": "OTP verified successfully.",
      "validationMessages": [""],
      "isSuccessful": true,
      "isBusinessError": false,
      "isSystemError": false,
      "systemErrorMessage": "null",
      "businessErrorMessage": "null"
    };
    return OTPResponseModel.fromJson(responseData);
  }
}
