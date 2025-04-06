class ParliamentDropResponseModel {
  List<ParliamentData>? data;
  String? message;
  List<String>? validationMessages;
  bool? isSuccessful;
  bool? isBusinessError;
  bool? isSystemError;
  String? systemErrorMessage;
  String? businessErrorMessage;

  ParliamentDropResponseModel(
      {this.data,
      this.message,
      this.validationMessages,
      this.isSuccessful,
      this.isBusinessError,
      this.isSystemError,
      this.systemErrorMessage,
      this.businessErrorMessage});

  ParliamentDropResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ParliamentData>[];
      json['data'].forEach((v) {
        data!.add(ParliamentData.fromJson(v));
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

class ParliamentData {
  int? idParliamentData;
  String? parliamentName;
  String? parliamentCode;
  int? stateMasterId;

  ParliamentData(
      {this.idParliamentData,
      this.parliamentName,
      this.parliamentCode,
      this.stateMasterId});

  ParliamentData.fromJson(Map<String, dynamic> json) {
    idParliamentData = json['idParliamentData'];
    parliamentName = json['parliamentName'];
    parliamentCode = json['parliamentCode'];
    stateMasterId = json['stateMasterId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idParliamentData'] = idParliamentData;
    data['parliamentName'] = parliamentName;
    data['parliamentCode'] = parliamentCode;
    data['stateMasterId'] = stateMasterId;
    return data;
  }
}
