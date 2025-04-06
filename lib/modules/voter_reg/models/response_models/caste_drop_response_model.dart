class CasteDropResponseModel {
  List<CasteData>? data;
  String? message;
  List<String>? validationMessages;
  bool? isSuccessful;
  bool? isBusinessError;
  bool? isSystemError;
  String? systemErrorMessage;
  String? businessErrorMessage;

  CasteDropResponseModel(
      {this.data,
      this.message,
      this.validationMessages,
      this.isSuccessful,
      this.isBusinessError,
      this.isSystemError,
      this.systemErrorMessage,
      this.businessErrorMessage});

  CasteDropResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CasteData>[];
      json['data'].forEach((v) {
        data!.add(CasteData.fromJson(v));
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

class CasteData {
  int? idCaste;
  int? religionId;
  String? casteName;

  CasteData({this.idCaste, this.religionId, this.casteName});

  CasteData.fromJson(Map<String, dynamic> json) {
    idCaste = json['idCaste'];
    religionId = json['religionId'];
    casteName = json['casteName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idCaste'] = idCaste;
    data['religionId'] = religionId;
    data['casteName'] = casteName;
    return data;
  }
}
