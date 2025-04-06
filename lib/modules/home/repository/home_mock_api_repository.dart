import 'package:voter_reg/modules/home/models/reaponse_models/voter_list_response_model.dart';
import 'package:voter_reg/utils/services/local_data.dart';

import 'home_api_repository.dart';

/// Mock implementation of [VoterRegApiRepository] for simulating login requests.
class HomeMockApiRepository implements HomeApiRepository {
  final LocalData localData;

  HomeMockApiRepository({required this.localData});

  @override
  Future<VoterListResponseModel?> fetchVoters() async {
    var data = await localData.getAllVoters();
    if (data != null) {
      return VoterListResponseModel(
        data: data,
        message: "Voters Fetched Successfully",
      );
    } else {
      return VoterListResponseModel(data: [], message: "No voters found.");
    }
  }
}
