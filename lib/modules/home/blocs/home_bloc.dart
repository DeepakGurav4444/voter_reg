import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:voter_reg/configs/routes/routes_name.dart';
import 'package:voter_reg/modules/home/models/reaponse_models/voter_list_response_model.dart';
import 'package:voter_reg/modules/home/repository/home_repository.dart';
import 'package:voter_reg/modules/voter_reg/enums/voter_action.dart';
import 'package:voter_reg/modules/voter_reg/models/data_models/voter_action_data.dart';
import 'package:voter_reg/modules/voter_reg/models/data_models/voter_data.dart';
import 'package:voter_reg/network_module/response/api_response.dart';
import 'package:voter_reg/utils/services/auth_data.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeApiRepository homeApiRepository;
  final BuildContext context;
  final AuthData authData;
  HomeBloc(
      {required this.authData,
      required this.homeApiRepository,
      required this.context})
      : super(HomeState()) {
    on<HomeEvent>((event, emit) {});
    on<OnClickAddButton>(onClickedAddButton);
    on<OnPageInitiated>(onInitiated);
    on<OnClickedListItem>(onClickedListItem);
    on<OnClickLogoutButton>(onClickedLogoutButton);
  }

  void onClickedAddButton(OnClickAddButton event, Emitter<HomeState> emit) {
    Navigator.pushNamed(context, RoutesName.voterReg,
            arguments: VoterActionData(action: VoterAction.add))
        .then((value) => add(OnPageInitiated()));
  }

  void onClickedListItem(OnClickedListItem event, Emitter<HomeState> emit) {
    Navigator.pushNamed(context, RoutesName.voterReg,
            arguments: VoterActionData(
                action: VoterAction.edit, voterEditData: event.voterData))
        .then((value) => add(OnPageInitiated()));
  }

  Future<void> onInitiated(
      OnPageInitiated event, Emitter<HomeState> emit) async {
    emit(state.copyWith(voterListApi: const ApiResponse.loading()));
    await homeApiRepository.fetchVoters().then((value) async {
      if (value != null && value.data != null) {
        emit(state.copyWith(voterListApi: ApiResponse.completed(value)));
      } else {
        emit(state.copyWith(voterListApi: ApiResponse.error("No data found.")));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(voterListApi: ApiResponse.error(error.toString())));
    });
  }

  Future<void> onClickedLogoutButton(
      OnClickLogoutButton event, Emitter<HomeState> emit) async {
    await authData.removeAuthData();
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.login, (route) => false);
    }
  }
}
