import 'package:voter_reg/modules/voter_reg/enums/voter_action.dart';
import 'package:voter_reg/modules/voter_reg/models/data_models/voter_data.dart';

class VoterActionData {
  final VoterData? voterEditData;
  final VoterAction action;

  const VoterActionData({this.voterEditData, required this.action});
}
