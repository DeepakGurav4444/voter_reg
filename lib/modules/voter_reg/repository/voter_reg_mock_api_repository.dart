import 'package:voter_reg/modules/voter_reg/models/response_models/add_voter_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/assembly_drop_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/caste_drop_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/category_drop_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/district_drop_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/parliament_drop_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/religion_drop_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/state_drop_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/update_voter_response_model.dart';
import 'package:voter_reg/utils/services/local_data.dart';
import 'voter_reg_api_repository.dart';

/// Mock implementation of [VoterRegApiRepository] for simulating login requests.
class VoterRegMockApiRepository implements VoterRegApiRepository {
  final LocalData localData;

  VoterRegMockApiRepository({required this.localData});
  @override
  Future<StateDropResponseModel> fetchStates() async {
    // Simulate a delay to mimic network latency
    await Future.delayed(const Duration(seconds: 2));
    // Mock response data
    var responseData = StateDropResponseModel(
        data: localData.stateList,
        message: "States retrieved successfullly.",
        validationMessages: [],
        isSuccessful: true,
        isBusinessError: false,
        isSystemError: false,
        systemErrorMessage: "",
        businessErrorMessage: "null");
    return responseData;
  }

  @override
  Future<DistrictDropResponseModel?> fetchDistrict(
      Map<String, String> body) async {
    await Future.delayed(const Duration(seconds: 2));
    var districtList = localData.districtList
        .where(
            (x) => x.stateMasterId == int.parse(body['stateMasterId'] ?? "0"))
        .toList();
    var responseData = DistrictDropResponseModel(
        data: districtList,
        message: districtList.isNotEmpty ? "" : "District not found.",
        validationMessages: [],
        isSuccessful: true,
        isBusinessError: false,
        isSystemError: false,
        systemErrorMessage: "",
        businessErrorMessage: "null");
    return responseData;
  }

  @override
  Future<ParliamentDropResponseModel?> fetchParliament() async {
    await Future.delayed(const Duration(seconds: 2));
    var responseData = ParliamentDropResponseModel(
      data: localData.parliamentList,
      message: "Parliaments retrieved successfully.",
      validationMessages: [],
      isSuccessful: true,
      isBusinessError: false,
      isSystemError: false,
      systemErrorMessage: null,
      businessErrorMessage: null,
    );
    return responseData;
  }

  @override
  Future<AssemblyDropResponseModel?> fetchAssembly(
      Map<String, String> body) async {
    await Future.delayed(const Duration(seconds: 2));

    var assemblyList = localData.assemblyList
        .where((x) => x.parliamentId == int.parse(body['parliamentId'] ?? "0"))
        .toList();

    var responseData = AssemblyDropResponseModel(
        data: assemblyList,
        message: assemblyList.isNotEmpty
            ? "Assemblies retrieved successfullly."
            : "Assemblies not found.",
        validationMessages: [],
        isSuccessful: true,
        isBusinessError: false,
        isSystemError: false,
        systemErrorMessage: null,
        businessErrorMessage: null);

    return responseData;
  }

  @override
  Future<ReligionDropResponseModel?> fetchReligion() async {
    await Future.delayed(const Duration(seconds: 2));
    var responseData = ReligionDropResponseModel(
        data: localData.religionList,
        message: "Religions retrieved successfullly.",
        validationMessages: [],
        isSuccessful: true,
        isBusinessError: false,
        isSystemError: false,
        systemErrorMessage: null,
        businessErrorMessage: null);
    return responseData;
  }

  @override
  Future<CasteDropResponseModel?> fetchCaste(Map<String, String> body) async {
    await Future.delayed(const Duration(seconds: 2));
    var casteList = localData.casteList
        .where((x) => x.religionId == int.parse(body['religionId'] ?? "0"))
        .toList();
    var responseData = CasteDropResponseModel(
        data: casteList,
        message: casteList.isNotEmpty
            ? "Castes retrieved successfullly."
            : "Castes not found.",
        validationMessages: [],
        isSuccessful: true,
        isBusinessError: false,
        isSystemError: false,
        systemErrorMessage: null,
        businessErrorMessage: null);
    return responseData;
  }

  @override
  Future<CategoryDropResponseModel?> fetchCategory(
      Map<String, String> body) async {
    await Future.delayed(const Duration(seconds: 2));
    var categoryList = localData.categoryList
        .where((x) => x.casteId == int.parse(body['casteId'] ?? "0"))
        .toList();
    var responseData = CategoryDropResponseModel(
        data: categoryList,
        message: categoryList.isNotEmpty
            ? "Category retrieved successfullly."
            : "Categories not found.",
        validationMessages: [],
        isSuccessful: true,
        isBusinessError: false,
        isSystemError: false,
        systemErrorMessage: null,
        businessErrorMessage: null);
    return responseData;
  }

  @override
  Future<AddVoterResponseModel?> registerVoter(
      Map<String, dynamic> body) async {
    var presentData = await localData.insertVoter(body);
    if (presentData != 0) {
      return AddVoterResponseModel(
        data: 1,
        message: "Voter Registered Successfully",
      );
    } else {
      return null;
    }
  }
  
  @override
  Future<UpdateVoterResponseModel?> updateVoter(Map<String, dynamic> body) async{
    var updateResult = await localData.updateVoter(body);
    if(updateResult==1){
      return UpdateVoterResponseModel(
        data: 1,
        message: "Voter Registered Successfully",
      );
    }else{
      return null;
    }
  }
}
