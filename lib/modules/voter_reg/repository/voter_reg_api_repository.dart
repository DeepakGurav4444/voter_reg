import 'package:voter_reg/modules/voter_reg/models/response_models/caste_drop_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/district_drop_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/religion_drop_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/state_drop_response_model.dart';

import '../models/response_models/add_voter_response_model.dart';
import '../models/response_models/assembly_drop_response_model.dart';
import '../models/response_models/category_drop_response_model.dart';
import '../models/response_models/parliament_drop_response_model.dart';
import '../models/response_models/update_voter_response_model.dart';

/// Abstract class defining methods for authentication API repositories.
abstract class VoterRegApiRepository {
  /// Sends a login request to the authentication API with the provided [data].
  ///
  /// Returns a [UserModel] representing the user data if the login is successful.
  Future<StateDropResponseModel?> fetchStates();
  Future<DistrictDropResponseModel?> fetchDistrict(Map<String, String> body);
  Future<ParliamentDropResponseModel?> fetchParliament();
  Future<AssemblyDropResponseModel?> fetchAssembly(Map<String, String> body);
  Future<ReligionDropResponseModel?> fetchReligion();
  Future<CasteDropResponseModel?> fetchCaste(Map<String, String> body);
  Future<CategoryDropResponseModel?> fetchCategory(Map<String, String> body);
  Future<AddVoterResponseModel?> registerVoter(Map<String, dynamic> body);
  Future<UpdateVoterResponseModel?> updateVoter(Map<String, dynamic> body);
}
