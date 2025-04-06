class DistrictDropResponseModel {
  List<DistrictData>? data;
  String? message;
  List<String>? validationMessages;
  bool? isSuccessful;
  bool? isBusinessError;
  bool? isSystemError;
  String? systemErrorMessage;
  String? businessErrorMessage;

  DistrictDropResponseModel(
      {this.data,
      this.message,
      this.validationMessages,
      this.isSuccessful,
      this.isBusinessError,
      this.isSystemError,
      this.systemErrorMessage,
      this.businessErrorMessage});

  DistrictDropResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DistrictData>[];
      json['data'].forEach((v) {
        data!.add(DistrictData.fromJson(v));
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

class DistrictData {
  int? idDistrictMaster;
  String? districtName;
  int? stateMasterId;

  DistrictData({this.idDistrictMaster, this.districtName, this.stateMasterId});

  DistrictData.fromJson(Map<String, dynamic> json) {
    idDistrictMaster = json['idDistrictMaster'];
    districtName = json['districtName'];
    stateMasterId = json['stateMasterId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idDistrictMaster'] = idDistrictMaster;
    data['districtName'] = districtName;
    data['stateMasterId'] = stateMasterId;
    return data;
  }
}
