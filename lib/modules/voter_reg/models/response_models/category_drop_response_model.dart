class CategoryDropResponseModel {
  List<CategoryData>? data;
  String? message;
  List<String>? validationMessages;
  bool? isSuccessful;
  bool? isBusinessError;
  bool? isSystemError;
  String? systemErrorMessage;
  String? businessErrorMessage;

  CategoryDropResponseModel(
      {this.data,
      this.message,
      this.validationMessages,
      this.isSuccessful,
      this.isBusinessError,
      this.isSystemError,
      this.systemErrorMessage,
      this.businessErrorMessage});

  CategoryDropResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data!.add(CategoryData.fromJson(v));
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

class CategoryData {
  int? idCategory;
  int? religionId;
  int? casteId;
  String? categoryName;

  CategoryData(
      {this.idCategory, this.religionId, this.casteId, this.categoryName});

  CategoryData.fromJson(Map<String, dynamic> json) {
    idCategory = json['idCategory'];
    religionId = json['religionId'];
    casteId = json['casteId'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idCategory'] = idCategory;
    data['religionId'] = religionId;
    data['casteId'] = casteId;
    data['categoryName'] = categoryName;
    return data;
  }
}
