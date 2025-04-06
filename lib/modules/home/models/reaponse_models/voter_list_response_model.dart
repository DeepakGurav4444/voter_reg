import 'package:voter_reg/modules/voter_reg/models/data_models/voter_data.dart';

class VoterListResponseModel {
  List<VoterData>? data;
  String? message;
  List<String>? validationMessages;
  bool? isSuccessful;
  bool? isBusinessError;
  bool? isSystemError;
  String? systemErrorMessage;
  String? businessErrorMessage;

  VoterListResponseModel(
      {this.data,
      this.message,
      this.validationMessages,
      this.isSuccessful,
      this.isBusinessError,
      this.isSystemError,
      this.systemErrorMessage,
      this.businessErrorMessage});

  VoterListResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <VoterData>[];
      json['data'].forEach((v) {
        data!.add(VoterData.fromJson(v));
      });
    }
    message = json['message'];
    validationMessages = json['validationMessages'].cast<String>();
    isSuccessful = json['isSuccessful'];
    isBusinessError = json['isBusinessError'];
    isSystemError = json['isSystemError'];
    systemErrorMessage = json['systemErrorMessage'];
    businessErrorMessage = json['businessErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['validationMessages'] = validationMessages;
    data['isSuccessful'] = isSuccessful;
    data['isBusinessError'] = isBusinessError;
    data['isSystemError'] = isSystemError;
    data['systemErrorMessage'] = systemErrorMessage;
    data['businessErrorMessage'] = businessErrorMessage;
    return data;
  }
}
