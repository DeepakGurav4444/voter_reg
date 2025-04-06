import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/district_drop_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/parliament_drop_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/religion_drop_response_model.dart';

import '../models/response_models/assembly_drop_response_model.dart';
import '../models/response_models/caste_drop_response_model.dart';
import '../models/response_models/category_drop_response_model.dart';
import '../models/response_models/state_drop_response_model.dart';

mixin VoterValidationBloc {
  // Streams for each input field
  final userFirstName = BehaviorSubject<String>();
  final userLastName = BehaviorSubject<String>();
  final userAddressLine1 = BehaviorSubject<String>();
  final userAddressLine2 = BehaviorSubject<String>();
  final userEmail = BehaviorSubject<String>();
  final userMobileNumber = BehaviorSubject<String>();
  final userAltNum = BehaviorSubject<String>();
  final userDOB = BehaviorSubject<String>();
  final userState = BehaviorSubject<StateData>();
  final userDistrict = BehaviorSubject<DistrictData>();
  final userReligion = BehaviorSubject<ReligionData>();
  final userCaste = BehaviorSubject<CasteData>();
  final userParliament = BehaviorSubject<ParliamentData?>.seeded(null);
  final userAssembly = BehaviorSubject<AssemblyData?>.seeded(null);
  final userCategory = BehaviorSubject<CategoryData>();
  final userVoterCode = BehaviorSubject<String?>.seeded(null);
  final userVoterId = BehaviorSubject<String>();
  final userZilla = BehaviorSubject<String?>.seeded(null);
//------------------------- Page 1 Streams-------------------------
  Stream<String> firstName(BuildContext pageContext) =>
      userFirstName.stream.transform(validateFirstName(pageContext));
  Stream<String> lastName(BuildContext pageContext) =>
      userLastName.stream.transform(validateLastName(pageContext));
  Stream<String> mobileNo(BuildContext pageContext) =>
      userMobileNumber.stream.transform(validateMobNum(pageContext));
  Stream<String> dob(BuildContext pageContext) =>
      userDOB.stream.transform(validateDOB(pageContext));
  Stream<String> email(BuildContext pageContext) =>
      userEmail.stream.transform(validateEmail(pageContext));

//----------------- Page 2 Streams----------------
  Stream<ReligionData> religionDrop(BuildContext pageContext) =>
      userReligion.stream.transform(validateReligion(pageContext));
  Stream<CasteData> casteDrop(BuildContext pageContext) =>
      userCaste.stream.transform(validateCaste(pageContext));
  Stream<CategoryData> categoryDrop(BuildContext pageContext) =>
      userCategory.stream.transform(validateCategory(pageContext));
  Stream<String?> voterCode(BuildContext pageContext) =>
      userVoterCode.stream.transform(validateVoterCode(pageContext));
  Stream<String?> voterId(BuildContext pageContext) =>
      userVoterId.stream.transform(validateVoterId(pageContext));
  Stream<ParliamentData?> parliamentDrop(BuildContext pageContext) =>
      userParliament.stream.transform(validateParliament(pageContext));
  Stream<AssemblyData?> assemblyDrop(BuildContext pageContext) =>
      userAssembly.stream.transform(validateAssembly(pageContext));

  //----------------- Page 3 Streams----------------
  Stream<String> addressLine1(BuildContext pageContext) =>
      userAddressLine1.stream.transform(validateAddressLine1(pageContext));
  Stream<String> addressLine2(BuildContext pageContext) =>
      userAddressLine2.stream.transform(validateAddressLine2(pageContext));
  // Stream<String> altNum(BuildContext pageContext) =>
  //     userAltNum.stream.transform(validateAltNum(pageContext));
  Stream<StateData> stateDrop(BuildContext pageContext) =>
      userState.stream.transform(validateState(pageContext));
  Stream<DistrictData> districtDrop(BuildContext pageContext) =>
      userDistrict.stream.transform(validateDistrict(pageContext));
  Stream<String?> zilla(BuildContext pageContext) =>
      userZilla.stream.transform(validateZilla(pageContext));

  StreamTransformer<String, String> validateFirstName(
          BuildContext pageContext) =>
      StreamTransformer<String, String>.fromHandlers(
          handleData: (checkBox, sink) {
        if (checkBox.isEmpty) {
          sink.addError("First name should not be empty.");
        } else {
          sink.add(checkBox);
        }
      });

  StreamTransformer<String, String> validateDOB(BuildContext pageContext) =>
      StreamTransformer<String, String>.fromHandlers(
        handleData: (date, sink) {
          final RegExp dateRegex =
              RegExp(r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$');

          if (dateRegex.hasMatch(date)) {
            sink.add(date);
          } else {
            sink.addError("Enter a valid date in dd/MM/yyyy format");
          }
        },
      );

  StreamTransformer<String, String> validateLastName(
          BuildContext pageContext) =>
      StreamTransformer<String, String>.fromHandlers(
          handleData: (checkBox, sink) {
        if (checkBox.isEmpty) {
          sink.addError("Last name should not be empty.");
        } else {
          sink.add(checkBox);
        }
      });

  StreamTransformer<String, String> validateAddressLine1(
          BuildContext pageContext) =>
      StreamTransformer<String, String>.fromHandlers(
          handleData: (checkBox, sink) {
        if (checkBox.isEmpty) {
          sink.addError("House number / Buiding name should not be empty.");
        } else {
          sink.add(checkBox);
        }
      });

  StreamTransformer<String, String> validateAddressLine2(
          BuildContext pageContext) =>
      StreamTransformer<String, String>.fromHandlers(
          handleData: (checkBox, sink) {
        if (checkBox.isEmpty) {
          sink.addError("Street name / Road name should not be empty.");
        } else {
          sink.add(checkBox);
        }
      });

  StreamTransformer<String, String> validateMobNum(BuildContext pageContext) =>
      StreamTransformer<String, String>.fromHandlers(
          handleData: (checkBox, sink) {
        if (checkBox.isEmpty) {
          sink.addError("Mobile number should not be empty.");
        } else if (!RegExp(r'^\d{10}$').hasMatch(checkBox)) {
          sink.addError("Enter a valid mobile number.");
        } else {
          sink.add(checkBox);
        }
      });

  StreamTransformer<String, String> validateAltNum(BuildContext pageContext) =>
      StreamTransformer<String, String>.fromHandlers(
          handleData: (checkBox, sink) {
        if (checkBox.isEmpty) {
          sink.addError("Alternate mobile number should not be empty.");
        } else {
          sink.add(checkBox);
        }
      });

  StreamTransformer<String, String> validateEmail(BuildContext pageContext) =>
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
        if (email.isEmpty) {
          sink.addError("Email should not be empty.");
        } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
            .hasMatch(email)) {
          sink.addError("Enter a valid email.");
        } else {
          sink.add(email);
        }
      });

  StreamTransformer<StateData, StateData> validateState(
          BuildContext pageContext) =>
      StreamTransformer<StateData, StateData>.fromHandlers(
          handleData: (state, sink) {
        if ((state.stateName ?? "").isEmpty) {
          sink.addError("State is mendatory.");
        } else {
          sink.add(state);
        }
      });

  StreamTransformer<DistrictData, DistrictData> validateDistrict(
          BuildContext pageContext) =>
      StreamTransformer<DistrictData, DistrictData>.fromHandlers(
          handleData: (district, sink) {
        if ((district.districtName ?? "").isEmpty) {
          sink.addError("District is mendatory.");
        } else {
          sink.add(district);
        }
      });

  StreamTransformer<ParliamentData?, ParliamentData?> validateParliament(
          BuildContext pageContext) =>
      StreamTransformer<ParliamentData?, ParliamentData?>.fromHandlers(
          handleData: (parliament, sink) {
        sink.add(parliament);
      });

  StreamTransformer<AssemblyData?, AssemblyData?> validateAssembly(
          BuildContext pageContext) =>
      StreamTransformer<AssemblyData?, AssemblyData?>.fromHandlers(
          handleData: (assembly, sink) {
        sink.add(assembly);
      });

  StreamTransformer<ReligionData, ReligionData> validateReligion(
          BuildContext pageContext) =>
      StreamTransformer<ReligionData, ReligionData>.fromHandlers(
          handleData: (religion, sink) {
        if ((religion.religion ?? "").isEmpty) {
          sink.addError("Religion is mendatory.");
        } else {
          sink.add(religion);
        }
      });

  StreamTransformer<CasteData, CasteData> validateCaste(
          BuildContext pageContext) =>
      StreamTransformer<CasteData, CasteData>.fromHandlers(
          handleData: (caste, sink) {
        if ((caste.casteName ?? "").isEmpty) {
          sink.addError("Caste is mendatory.");
        } else {
          sink.add(caste);
        }
      });

  StreamTransformer<CategoryData, CategoryData> validateCategory(
          BuildContext pageContext) =>
      StreamTransformer<CategoryData, CategoryData>.fromHandlers(
          handleData: (category, sink) {
        if ((category.categoryName ?? "").isEmpty) {
          sink.addError("Category is mendatory.");
        } else {
          sink.add(category);
        }
      });

  StreamTransformer<String?, String?> validateVoterCode(
          BuildContext pageContext) =>
      StreamTransformer<String?, String?>.fromHandlers(
          handleData: (voterCode, sink) {
        if (voterCode != null && voterCode.isEmpty) {
          sink.add(null);
        } else if (voterCode != null &&
            voterCode.isNotEmpty &&
            !RegExp(r'^[A-Z0-9]{8}$').hasMatch(voterCode)) {
          sink.addError("Enter 8 digit voter code.");
        } else {
          sink.add(voterCode);
        }
      });

  StreamTransformer<String, String> validateVoterId(BuildContext pageContext) =>
      StreamTransformer<String, String>.fromHandlers(
          handleData: (voterId, sink) {
        if (voterId.isEmpty) {
          sink.addError("Voter Id should not be empty.");
        } else if (!RegExp(r'^[A-Z]{3}\d{7}$').hasMatch(voterId)) {
          sink.addError("Enter valid Voter Id.");
        } else {
          sink.add(voterId);
        }
      });

  StreamTransformer<String?, String?> validateZilla(BuildContext pageContext) =>
      StreamTransformer<String?, String?>.fromHandlers(
          handleData: (zilla, sink) {
        if (zilla != null && zilla.isEmpty) {
          sink.add(null);
        } else {
          sink.add(zilla);
        }
      });

  Stream<bool> validatePage1(BuildContext context) => Rx.combineLatest5(
      firstName(context),
      lastName(context),
      email(context),
      mobileNo(context),
      dob(context),
      (a, b, c, d, e) => true).startWith(false);

  Stream<bool> validatePage2(BuildContext context) => Rx.combineLatest7(
      religionDrop(context),
      casteDrop(context),
      categoryDrop(context),
      assemblyDrop(context),
      parliamentDrop(context),
      voterCode(context),
      voterId(context),
      (a, b, c, d, e, f, g) => true).startWith(false);

  Stream<bool> validatePage3(BuildContext context) => Rx.combineLatest5(
      stateDrop(context),
      districtDrop(context),
      addressLine1(context),
      addressLine2(context),
      zilla(context),
      (a, b, c, d, e) => true).startWith(false);

  Stream<bool> validateAccToPage(BuildContext context, int index) => index == 0
      ? validatePage1(context)
      : index == 1
          ? validatePage2(context)
          : validatePage3(context);

  //Validating Buttons

  Function(String) get changeFirstName => userFirstName.sink.add;
  Function(String) get changeLastName => userLastName.sink.add;
  Function(String) get changeAddressLine1 => userAddressLine1.sink.add;
  Function(String) get changeAddressLine2 => userAddressLine2.sink.add;
  Function(String) get changeAltNumber => userAltNum.sink.add;
  Function(String) get changeMobNum => userMobileNumber.sink.add;
  Function(String) get changeEmail => userEmail.sink.add;
  Function(String) get changeDOB => userDOB.sink.add;
  Function(StateData) get changeState => userState.sink.add;
  Function(DistrictData) get changeDistrict => userDistrict.sink.add;
  Function(ParliamentData?) get changeParliament => userParliament.sink.add;
  Function(AssemblyData?) get changeAssembly => userAssembly.sink.add;
  Function(ReligionData) get changereligion => userReligion.sink.add;
  Function(CasteData) get changeCaste => userCaste.sink.add;
  Function(CategoryData) get changeCategory => userCategory.sink.add;
  Function(String?) get changeVoterCode => userVoterCode.sink.add;
  Function(String) get changeVoterId => userVoterId.sink.add;
  Function(String?) get changeZilla => userZilla.sink.add;
}
