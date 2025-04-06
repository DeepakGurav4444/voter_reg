import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:voter_reg/modules/voter_reg/blocs/voter_validation_bloc.dart';
import 'package:voter_reg/modules/voter_reg/models/data_models/voter_action_data.dart';
import 'package:voter_reg/modules/voter_reg/models/request_models/add_voter_request_model.dart';
import 'package:voter_reg/modules/voter_reg/models/request_models/update_voter_request_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/assembly_drop_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/caste_drop_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/district_drop_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/parliament_drop_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/religion_drop_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/state_drop_response_model.dart';
import 'package:voter_reg/network_module/response/api_response.dart';
import 'package:voter_reg/modules/voter_reg/repository/voter_reg_api_repository.dart';
import 'package:voter_reg/utils/extensions/flush_bar_extension.dart';
import '../../../configs/components/loading_overlay.dart';
import '../enums/voter_action.dart';
import '../models/response_models/category_drop_response_model.dart';
part 'voter_reg_event.dart';
part 'voter_reg_state.dart';

class VoterRegBloc extends Bloc<VoterRegEvent, VoterRegState>
    with VoterValidationBloc {
  final BuildContext context;
  final VoterRegApiRepository voterRegApiRepository;
  late PageController regPageController;
  late TextEditingController firstNameController;
  late TextEditingController zillaController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController mobileNumController;
  late TextEditingController addressLine1Controller;
  late TextEditingController addressLine2Controller;
  late TextEditingController dOBController;
  late TextEditingController altMobNumController;
  late TextEditingController voterCodeController;
  late TextEditingController voterIdController;
  VoterRegBloc({required this.context, required this.voterRegApiRepository})
      : super(VoterRegState()) {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    mobileNumController = TextEditingController();
    addressLine1Controller = TextEditingController();
    addressLine2Controller = TextEditingController();
    dOBController = TextEditingController();
    altMobNumController = TextEditingController();
    voterCodeController = TextEditingController();
    voterIdController = TextEditingController();
    zillaController = TextEditingController();
    regPageController = PageController(initialPage: state.currentPage);
    on<VoterRegEvent>((event, emit) {});
    on<OnVoterRegInitiated>(onIntiated);
    on<OnDatePickerClicked>((event, emit) async => await selectDate(context));
    on<OnStateChanged>(onStateChanged);
    on<OnDistrictChanged>(onDistrictChanged);
    on<OnParliamentChanged>(onParliamentChanged);
    on<OnAssemblyChanged>(onAssemblyChanged);
    on<OnRemoveDate>((event, emit) => removeDate());
    on<OnReligionChanged>(onReligionChanged);
    on<OnCasteChanged>(onCasteChanged);
    on<OnCategoryChanged>(onCategoryChanged);
    on<OnClickPrevious>(onClickedPreviousButton);
    on<OnClickNext>(onClickedNextButton);
  }

  Future<void> selectDate(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    DateTime currentDate = DateTime.now();
    DateTime eighteenYearsAgo =
        DateTime(currentDate.year - 18, currentDate.month, currentDate.day);
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: eighteenYearsAgo, // Default selected date
      firstDate: DateTime(currentDate.year - 100), // Start date 100 years ago
      lastDate: currentDate,
      builder: (context, child) => Theme(
        data: ThemeData.light().copyWith(
          buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        child: child!,
      ),
    );

    if (picked != null) {
      changeDOB(DateFormat("dd/MM/yyyy").format(picked));
      dOBController.text = DateFormat("dd/MM/yyyy")
          .format(picked); // Make sure the date format is correct
    }
  }

  void removeDate() => changeDOB("");

  Future<void> onIntiated(
    OnVoterRegInitiated event,
    Emitter<VoterRegState> emit,
  ) async {
    var action = ModalRoute.of(context)!.settings.arguments as VoterActionData;
    if (action.action == VoterAction.edit) {
      LoadingOverlay.showLoading(context);
      firstNameController.text = action.voterEditData!.firstName ?? "";
      changeFirstName(action.voterEditData!.firstName ?? "");
      lastNameController.text = action.voterEditData!.lastName ?? "";
      changeLastName(action.voterEditData!.lastName ?? "");
      emailController.text = action.voterEditData!.emailId ?? "";
      changeEmail(action.voterEditData!.emailId ?? "");
      mobileNumController.text = action.voterEditData!.mobileNo ?? "";
      changeMobNum(action.voterEditData!.mobileNo ?? "");
      addressLine1Controller.text = action.voterEditData!.addressLine1 ?? "";
      changeAddressLine1(action.voterEditData!.addressLine1 ?? "");
      addressLine2Controller.text = action.voterEditData!.addressLine2 ?? "";
      changeAddressLine2(action.voterEditData!.addressLine2 ?? "");
      dOBController.text = action.voterEditData!.dob ?? "";
      changeDOB(action.voterEditData!.dob ?? "");
      voterCodeController.text = action.voterEditData!.refCode ?? "";
      changeVoterCode(action.voterEditData!.refCode ?? "");
      voterIdController.text = action.voterEditData!.voterId ?? "";
      changeVoterId(action.voterEditData!.voterId ?? "");
      zillaController.text = action.voterEditData!.zilla ?? "";
      changeZilla(action.voterEditData!.zilla ?? "");
    }
    emit(state.copyWith(
        statesList: const ApiResponse.loading(), voterActionData: action));
    await voterRegApiRepository.fetchStates().then((value) async {
      if (value != null && (value.data ?? []).isNotEmpty) {
        emit(state.copyWith(statesList: ApiResponse.completed(value)));
        if (state.voterActionData.action == VoterAction.edit &&
            state.selectedState == null) {
          var selectedState = value.data!.firstWhere((element) =>
              element.idStateMaster == action.voterEditData!.stateId);
          add(OnStateChanged(selectedState: selectedState));
        }
      } else {
        emit(
            state.copyWith(statesList: ApiResponse.error("States not found.")));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(statesList: ApiResponse.error(error.toString())));
    });

    emit(state.copyWith(religionList: const ApiResponse.loading()));
    await voterRegApiRepository.fetchReligion().then((value) async {
      if (value != null && (value.data ?? []).isNotEmpty) {
        emit(state.copyWith(religionList: ApiResponse.completed(value)));
        if (state.voterActionData.action == VoterAction.edit &&
            state.selectedReligion == null) {
          var selectedReligion = value.data!.firstWhere((element) =>
              element.idReligion == action.voterEditData!.religionId);
          add(OnReligionChanged(selectedReligionData: selectedReligion));
        }
      } else {
        emit(state.copyWith(
            religionList: ApiResponse.error("Religion not found.")));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(religionList: ApiResponse.error(error.toString())));
    });

    emit(state.copyWith(parliamentList: const ApiResponse.loading()));
    await voterRegApiRepository.fetchParliament().then((value) async {
      if (value != null && (value.data ?? []).isNotEmpty) {
        emit(state.copyWith(parliamentList: ApiResponse.completed(value)));
        if (state.voterActionData.action == VoterAction.edit &&
            state.selectedParliament == null) {
          var selectedParliament = value.data!.firstWhere((element) =>
              element.idParliamentData == action.voterEditData!.parliamentId);
          add(OnParliamentChanged(selectedParliament: selectedParliament));
        }
      } else {
        emit(state.copyWith(
            parliamentList: ApiResponse.error("Parliament not found.")));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(parliamentList: ApiResponse.error(error.toString())));
    });
    if (action.action == VoterAction.edit) {
      LoadingOverlay.hideLoading();
    }
  }

  Future<void> onStateChanged(
      OnStateChanged event, Emitter<VoterRegState> emit) async {
    emit(state.copyWith(selectedState: event.selectedState));
    if (event.selectedState.stateName!.isEmpty) {
      changeState(event.selectedState);
    } else {
      changeState(event.selectedState);
      if (state.selectedDistrict != null &&
          state.selectedDistrict!.districtName!.isNotEmpty) {
        onDistrictChanged(
            OnDistrictChanged(selectedDistrict: DistrictData(districtName: "")),
            emit);
      }
      emit(state.copyWith(districtList: const ApiResponse.loading()));
      await voterRegApiRepository.fetchDistrict({
        "stateMasterId": "${event.selectedState.idStateMaster ?? 0}"
      }).then((value) async {
        if (value != null && (value.data ?? []).isNotEmpty) {
          emit(state.copyWith(districtList: ApiResponse.completed(value)));
          if (state.voterActionData.action == VoterAction.edit &&
              state.selectedDistrict == null) {
            var selectedDistrict = value.data!.firstWhere((element) =>
                element.idDistrictMaster ==
                state.voterActionData.voterEditData!.districtId);
            onDistrictChanged(
                OnDistrictChanged(selectedDistrict: selectedDistrict), emit);
          }
        } else {
          emit(state.copyWith(
              statesList: ApiResponse.error("District not found.")));
        }
      }).onError((error, stackTrace) {
        emit(state.copyWith(districtList: ApiResponse.error(error.toString())));
      });
    }
  }

  Future<void> onDistrictChanged(
      OnDistrictChanged event, Emitter<VoterRegState> emit) async {
    emit(state.copyWith(selectedDistrict: event.selectedDistrict));
    changeDistrict(event.selectedDistrict);
  }

  Future<void> onParliamentChanged(
      OnParliamentChanged event, Emitter<VoterRegState> emit) async {
    emit(state.copyWith(selectedParliament: event.selectedParliament));
    changeParliament(event.selectedParliament);
    if (state.selectedAssembly != null) {
      changeAssembly(null);
    }
    if (event.selectedParliament != null) {
      emit(state.copyWith(assemblyList: const ApiResponse.loading()));
      await voterRegApiRepository.fetchAssembly({
        "parliamentId": "${event.selectedParliament!.idParliamentData ?? 0}"
      }).then((value) async {
        if (value != null && (value.data ?? []).isNotEmpty) {
          emit(state.copyWith(assemblyList: ApiResponse.completed(value)));
          if (state.voterActionData.action == VoterAction.edit &&
              state.selectedAssembly == null) {
            var selectedAssembly = value.data!.firstWhere((element) =>
                element.idAssemblyData ==
                state.voterActionData.voterEditData!.assemblyId);
            onAssemblyChanged(
                OnAssemblyChanged(selectedAssemblyData: selectedAssembly),
                emit);
          }
        } else {
          emit(state.copyWith(
              assemblyList: ApiResponse.error("Parliament not found.")));
        }
      }).onError((error, stackTrace) {
        emit(state.copyWith(assemblyList: ApiResponse.error(error.toString())));
      });
    }
  }

  Future<void> onAssemblyChanged(
      OnAssemblyChanged event, Emitter<VoterRegState> emit) async {
    emit(state.copyWith(selectedAssembly: event.selectedAssemblyData));
    changeAssembly(event.selectedAssemblyData);
  }

  Future<void> onReligionChanged(
      OnReligionChanged event, Emitter<VoterRegState> emit) async {
    emit(state.copyWith(selectedReligion: event.selectedReligionData));
    if (event.selectedReligionData.religion!.isEmpty) {
      changereligion(event.selectedReligionData);
    } else {
      changereligion(event.selectedReligionData);
      if (state.selectedCaste != null &&
          state.selectedCaste!.casteName!.isNotEmpty) {
        onCasteChanged(
            OnCasteChanged(
              selectedCasteData: CasteData(casteName: ""),
            ),
            emit);
        if (state.selectedCategory != null &&
            state.selectedCategory!.categoryName!.isNotEmpty) {
          onCategoryChanged(
              OnCategoryChanged(
                selectedCategoryData: CategoryData(categoryName: ""),
              ),
              emit);
        }
      }
      emit(state.copyWith(casteList: const ApiResponse.loading()));
      await voterRegApiRepository.fetchCaste({
        "religionId": "${event.selectedReligionData.idReligion ?? 0}"
      }).then((value) async {
        if (value != null && (value.data ?? []).isNotEmpty) {
          emit(state.copyWith(casteList: ApiResponse.completed(value)));
          if (state.voterActionData.action == VoterAction.edit &&
              state.selectedCaste == null) {
            var selectedCaste = value.data!.firstWhere((element) =>
                element.idCaste ==
                state.voterActionData.voterEditData!.casteId);
            add(OnCasteChanged(selectedCasteData: selectedCaste));
          }
        } else {
          emit(state.copyWith(
              casteList: ApiResponse.error("Castes not found.")));
        }
      }).onError((error, stackTrace) {
        emit(state.copyWith(casteList: ApiResponse.error(error.toString())));
      });
    }
  }

  Future<void> onCasteChanged(
      OnCasteChanged event, Emitter<VoterRegState> emit) async {
    emit(state.copyWith(selectedCaste: event.selectedCasteData));
    if (event.selectedCasteData.casteName!.isEmpty) {
      changeCaste(event.selectedCasteData);
    } else {
      changeCaste(event.selectedCasteData);
      if (state.selectedCategory != null &&
          state.selectedCategory!.categoryName!.isNotEmpty) {
        onCategoryChanged(
            OnCategoryChanged(
              selectedCategoryData: CategoryData(categoryName: ""),
            ),
            emit);
      }
      emit(state.copyWith(categoryList: const ApiResponse.loading()));
      await voterRegApiRepository.fetchCategory({
        "casteId": "${event.selectedCasteData.idCaste ?? 0}"
      }).then((value) async {
        if (value != null && (value.data ?? []).isNotEmpty) {
          emit(state.copyWith(categoryList: ApiResponse.completed(value)));
          if (state.voterActionData.action == VoterAction.edit &&
              state.selectedCategory == null) {
            var selectedCategory = value.data!.firstWhere((element) =>
                element.idCategory ==
                state.voterActionData.voterEditData!.categoryId);
            add(OnCategoryChanged(selectedCategoryData: selectedCategory));
          }
        } else {
          emit(state.copyWith(
              casteList: ApiResponse.error("Category not found.")));
        }
      }).onError((error, stackTrace) {
        emit(state.copyWith(categoryList: ApiResponse.error(error.toString())));
      });
    }
  }

  Future<void> onCategoryChanged(
      OnCategoryChanged event, Emitter<VoterRegState> emit) async {
    emit(state.copyWith(selectedCategory: event.selectedCategoryData));
    changeCategory(event.selectedCategoryData);
  }

  onClickedPreviousButton(OnClickPrevious event, Emitter<VoterRegState> emit) {
    if (state.currentPage != 0) {
      regPageController.animateToPage(state.currentPage - 1,
          duration: Duration(milliseconds: 500), curve: Curves.linear);
      emit(state.copyWith(currentPage: state.currentPage - 1));
    }
  }

  onClickedNextButton(OnClickNext event, Emitter<VoterRegState> emit) async {
    if (state.currentPage != 2) {
      regPageController.animateToPage(state.currentPage + 1,
          duration: Duration(milliseconds: 500), curve: Curves.linear);
      emit(state.copyWith(currentPage: state.currentPage + 1));
    } else {
      try {
        emit(state.copyWith(registerApi: const ApiResponse.loading()));
        LoadingOverlay.showLoading(context); // Pass context from event
        var requestBody = state.voterActionData.action == VoterAction.add
            ? AddVoterRequestModel(
                    mobileNo: userMobileNumber.value,
                    firstName: userFirstName.value,
                    lastName: userLastName.value,
                    emailId: userEmail.value,
                    addressLine1: userAddressLine1.value,
                    addressLine2: userAddressLine2.value,
                    districtId: userDistrict.value.idDistrictMaster,
                    assemblyId: userAssembly.valueOrNull?.idAssemblyData,
                    casteId: userCaste.value.idCaste,
                    categoryId: userCategory.value.idCategory,
                    dob: userDOB.value,
                    stateId: userState.value.idStateMaster,
                    religionId: userReligion.value.idReligion,
                    voterId: userVoterId.value,
                    zilla: userZilla.valueOrNull,
                    refCode: userVoterCode.valueOrNull,
                    parliamentId: userParliament.valueOrNull?.idParliamentData)
                .toJson()
            : UpdateVoterRequestModel(
                    idVoterData:
                        state.voterActionData.voterEditData!.idVoterData,
                    mobileNo: userMobileNumber.value,
                    firstName: userFirstName.value,
                    lastName: userLastName.value,
                    emailId: userEmail.value,
                    addressLine1: userAddressLine1.value,
                    addressLine2: userAddressLine2.value,
                    districtId: userDistrict.value.idDistrictMaster,
                    assemblyId: userAssembly.valueOrNull?.idAssemblyData,
                    casteId: userCaste.value.idCaste,
                    categoryId: userCategory.value.idCategory,
                    dob: userDOB.value,
                    stateId: userState.value.idStateMaster,
                    religionId: userReligion.value.idReligion,
                    voterId: userVoterId.value,
                    zilla: userZilla.valueOrNull,
                    refCode: userVoterCode.valueOrNull,
                    parliamentId: userParliament.valueOrNull?.idParliamentData)
                .toJson();
        dynamic resValue = state.voterActionData.action == VoterAction.add
            ? await voterRegApiRepository.registerVoter(requestBody)
            : await voterRegApiRepository.updateVoter(requestBody);
        LoadingOverlay.hideLoading();
        if (resValue != null && resValue.data == 1) {
          emit(state.copyWith(
              registerApi: ApiResponse.completed(resValue.data!)));
          if (context.mounted) {
            Navigator.pop(context);
            await context.flushBarSuccessMessage(message: resValue.message);
          }
        } else {
          emit(state.copyWith(
              registerApi: ApiResponse.error(resValue!.message ?? "")));
        }
      } catch (error, stackTrace) {
        debugPrint(error.toString() + stackTrace.toString());
        emit(state.copyWith(
          registerApi: ApiResponse.error(error.toString()),
        ));
      }
    }
  }
}
