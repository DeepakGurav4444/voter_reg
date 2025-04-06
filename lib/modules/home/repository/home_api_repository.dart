import 'package:voter_reg/modules/home/models/reaponse_models/voter_list_response_model.dart';

abstract class HomeApiRepository {
  /// Sends a login request to the authentication API with the provided [data].
  ///
  /// Returns a [UserModel] representing the user data if the login is successful.
  Future<VoterListResponseModel?> fetchVoters();
}
