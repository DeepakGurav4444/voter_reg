import 'package:voter_reg/modules/otp/models/otp_response_model.dart';
import 'package:voter_reg/modules/otp/repository/otp_api_repository.dart';

// import '../../network_module/network/base_api_services.dart';
// import '../../network_module/network/network.dart';

class OTPHttpApiRepository implements OTPApiRepository {
  // final BaseApiServices _apiServices = NetworkApiService();

  @override
  Future<OTPResponseModel?> rsendOTP(Map<String, String> body) {
    // TODO: implement rsendOTP
    throw UnimplementedError();
  }

  @override
  Future<OTPResponseModel?> sendOTP(Map<String, String> body) {
    // TODO: implement sendOTP
    throw UnimplementedError();
  }

  @override
  Future<OTPResponseModel?> verifyOTP(Map<String, String> body) {
    // TODO: implement verifyOTP
    throw UnimplementedError();
  }
}
