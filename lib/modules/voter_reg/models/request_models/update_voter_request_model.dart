class UpdateVoterRequestModel {
  int? idVoterData;
  String? refCode;
  String? voterId;
  String? firstName;
  String? lastName;
  String? mobileNo;
  String? emailId;
  String? dob;
  String? addressLine1;
  String? addressLine2;
  int? districtId;
  int? stateId;
  int? religionId;
  int? casteId;
  int? categoryId;
  String? zilla;
  int? parliamentId;
  int? assemblyId;

  UpdateVoterRequestModel(
      {this.idVoterData,
      this.refCode,
      this.voterId,
      this.firstName,
      this.lastName,
      this.mobileNo,
      this.emailId,
      this.dob,
      this.addressLine1,
      this.addressLine2,
      this.districtId,
      this.stateId,
      this.religionId,
      this.casteId,
      this.categoryId,
      this.zilla,
      this.parliamentId,
      this.assemblyId});

  UpdateVoterRequestModel.fromJson(Map<String, dynamic> json) {
    idVoterData = json['idVoterData'];
    refCode = json['refCode'];
    voterId = json['voterId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobileNo = json['mobileNo'];
    emailId = json['emailId'];
    dob = json['dob'];
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    districtId = json['districtId'];
    stateId = json['stateId'];
    religionId = json['religionId'];
    casteId = json['casteId'];
    categoryId = json['categoryId'];
    zilla = json['zilla'];
    parliamentId = json['parliamentId'];
    assemblyId = json['assemblyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idVoterData'] = idVoterData;
    data['refCode'] = refCode;
    data['voterId'] = voterId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['mobileNo'] = mobileNo;
    data['emailId'] = emailId;
    data['dob'] = dob;
    data['addressLine1'] = addressLine1;
    data['addressLine2'] = addressLine2;
    data['districtId'] = districtId;
    data['stateId'] = stateId;
    data['religionId'] = religionId;
    data['casteId'] = casteId;
    data['categoryId'] = categoryId;
    data['zilla'] = zilla;
    data['parliamentId'] = parliamentId;
    data['assemblyId'] = assemblyId;
    return data;
  }
}
