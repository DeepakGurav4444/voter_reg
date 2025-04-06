import 'package:voter_reg/modules/voter_reg/models/response_models/add_voter_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/assembly_drop_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/caste_drop_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/category_drop_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/district_drop_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/parliament_drop_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/religion_drop_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/state_drop_response_model.dart';
import 'package:voter_reg/network_module/network/api_path.dart';
import 'package:voter_reg/network_module/network/base_api_services.dart';
import 'package:voter_reg/network_module/network/network_api_services.dart';

import '../models/response_models/update_voter_response_model.dart';
import 'voter_reg_api_repository.dart';

/// Implementation of [LoginApiRepository] for making HTTP requests to the Loginentication API.
class VoterRegHttpApiRepository implements VoterRegApiRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  /// Sends a login request to the Loginentication API with the provided [data].
  ///
  /// Returns a [UserModel] representing the user data if the login is successful.
  @override
  Future<StateDropResponseModel?> fetchStates() async {
    dynamic response = await _apiServices.getApi(
        url: APIPathHelper.getValue(APIPath.getStateDrop));
    return StateDropResponseModel.fromJson(response);
  }

  @override
  Future<DistrictDropResponseModel?> fetchDistrict(
      Map<String, String> body) async {
    dynamic response = await _apiServices.getApi(
        url: APIPathHelper.getValue(APIPath.getDistrictDrop), params: body);
    return DistrictDropResponseModel.fromJson(response);
  }

  @override
  Future<ParliamentDropResponseModel?> fetchParliament() async {
    dynamic response = await _apiServices.getApi(
        url: APIPathHelper.getValue(APIPath.getParliamentDrop));
    return ParliamentDropResponseModel.fromJson(response);
  }

  @override
  Future<AssemblyDropResponseModel?> fetchAssembly(
      Map<String, String> body) async {
    dynamic response = await _apiServices.getApi(
        url: APIPathHelper.getValue(APIPath.getAssemblyDrop), params: body);
    return AssemblyDropResponseModel.fromJson(response);
  }

  @override
  Future<ReligionDropResponseModel?> fetchReligion() {
    // TODO: implement fetchReligion
    throw UnimplementedError();
  }

  @override
  Future<CasteDropResponseModel?> fetchCaste(Map<String, String> body) {
    // TODO: implement fetchCaste
    throw UnimplementedError();
  }

  @override
  Future<CategoryDropResponseModel?> fetchCategory(Map<String, String> body) {
    // TODO: implement fetchCategory
    throw UnimplementedError();
  }

  @override
  Future<AddVoterResponseModel?> registerVoter(Map<String, dynamic> body) {
    // TODO: implement registerVoter
    throw UnimplementedError();
  }
  
  @override
  Future<UpdateVoterResponseModel?> updateVoter(Map<String, dynamic> body) {
    // TODO: implement updateVoter
    throw UnimplementedError();
  }
}
