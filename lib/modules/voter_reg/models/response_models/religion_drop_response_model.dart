class ReligionDropResponseModel {
  List<ReligionData>? data;
  String? message;
  List<String>? validationMessages;
  bool? isSuccessful;
  bool? isBusinessError;
  bool? isSystemError;
  String? systemErrorMessage;
  String? businessErrorMessage;

  ReligionDropResponseModel(
      {this.data,
      this.message,
      this.validationMessages,
      this.isSuccessful,
      this.isBusinessError,
      this.isSystemError,
      this.systemErrorMessage,
      this.businessErrorMessage});

  ReligionDropResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ReligionData>[];
      json['data'].forEach((v) {
        data!.add(ReligionData.fromJson(v));
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

class ReligionData {
  int? idReligion;
  String? religion;

  ReligionData({this.idReligion, this.religion});

  ReligionData.fromJson(Map<String, dynamic> json) {
    idReligion = json['idReligion'];
    religion = json['religion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idReligion'] = idReligion;
    data['religion'] = religion;
    return data;
  }
}
