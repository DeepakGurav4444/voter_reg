import '../models/reaponse_models/voter_list_response_model.dart';
import 'home_api_repository.dart';

/// Implementation of [LoginApiRepository] for making HTTP requests to the Loginentication API.
class HomeHttpApiRepository implements HomeApiRepository {
  // final BaseApiServices _apiServices = NetworkApiService();

  @override
  Future<VoterListResponseModel?> fetchVoters() async {
    // TODO: implement fetchVoters
    throw UnimplementedError();
  }

  

  /// Sends a login request to the Loginentication API with the provided [data].
  ///
  /// Returns a [UserModel] representing the user data if the login is successful.
}
