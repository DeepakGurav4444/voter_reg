class AssemblyDropResponseModel {
  List<AssemblyData>? data;
  String? message;
  List<String>? validationMessages;
  bool? isSuccessful;
  bool? isBusinessError;
  bool? isSystemError;
  String? systemErrorMessage;
  String? businessErrorMessage;

  AssemblyDropResponseModel(
      {this.data,
      this.message,
      this.validationMessages,
      this.isSuccessful,
      this.isBusinessError,
      this.isSystemError,
      this.systemErrorMessage,
      this.businessErrorMessage});

  AssemblyDropResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AssemblyData>[];
      json['data'].forEach((v) {
        data!.add(AssemblyData.fromJson(v));
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

class AssemblyData {
  int? idAssemblyData;
  String? assemblyName;
  String? assemblyCode;
  int? parliamentId;
  int? stateMasterId;

  AssemblyData(
      {this.idAssemblyData,
      this.assemblyName,
      this.assemblyCode,
      this.parliamentId,
      this.stateMasterId});

  AssemblyData.fromJson(Map<String, dynamic> json) {
    idAssemblyData = json['idAssemblyData'];
    assemblyName = json['assemblyName'];
    assemblyCode = json['assemblyCode'];
    parliamentId = json['parliamentId'];
    stateMasterId = json['stateMasterId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idAssemblyData'] = idAssemblyData;
    data['assemblyName'] = assemblyName;
    data['assemblyCode'] = assemblyCode;
    data['parliamentId'] = parliamentId;
    data['stateMasterId'] = stateMasterId;
    return data;
  }
}
