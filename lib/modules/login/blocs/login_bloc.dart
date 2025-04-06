import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:voter_reg/network_module/response/api_response.dart';
import 'package:voter_reg/modules/otp/repository/otp_api_repository.dart';
import 'package:voter_reg/utils/services/auth_data.dart';

import '../../../../configs/components/loading_overlay.dart';
import '../../../../configs/routes/routes_name.dart';
import 'login_validation_bloc.dart';
// import 'package:voter_reg/repository/login_repository.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with LoginValidationBloc {
  final BuildContext context;
  final OTPApiRepository otpApiRepository;
  final AuthData authData;
  late TextEditingController mobileNumController;
  late TextEditingController otpController;
  Timer? timer;
  LoginBloc({required this.authData, required this.context, required this.otpApiRepository})
      : super(LoginState()) {
    mobileNumController = TextEditingController();
    otpController = TextEditingController();
    on<LoginEvent>((event, emit) {});
    on<OnClickSendOtp>(onClickedSendOTPButton);
    on<OnClickedVerifyOtp>(onClickedVerifyOTPButton);
    on<OnClickResetButton>(onClickedResetButton);
    on<OnClickReSendOtp>(onClickedReSendOtpButton);
    on<StartOtpTimer>(startOtpTimer);
    on<ResetOTPTimer>(resetOTPTimer);
    on<UpdateOtpTimer>(updateOTPTimer);
  }

  Future<void> startOtpTimer(
      StartOtpTimer event, Emitter<LoginState> emit) async {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Add a new event to handle the timer tick
      add(UpdateOtpTimer());
    });
    // while (secondsLeft > 0) {
    //   await Future.delayed(const Duration(seconds: 1));

    //   // Check if Bloc is still active before emitting
    //   if (emit.isDone) return;

    //   secondsLeft--;
    //   emit(state.copyWith(otpTimer: secondsLeft));
    // }
    // // timer?.cancel();
    // emit(state.copyWith(isResendEnabled: true));
  }

  void resetOTPTimer(ResetOTPTimer event, Emitter<LoginState> emit) {
    timer?.cancel();
    emit(state.copyWith(otpTimer: 60));
    emit(state.copyWith(isResendEnabled: false));
  }

  void updateOTPTimer(UpdateOtpTimer event, Emitter<LoginState> emit) {
    if (state.otpTimer > 0) {
      emit(state.copyWith(otpTimer: state.otpTimer - 1));
    } else {
      timer?.cancel();
      emit(state.copyWith(isResendEnabled: true));
    }
  }

  void onClickedResetButton(
      OnClickResetButton event, Emitter<LoginState> emit) {
    mobileNumController.text = "";
    otpController.text = "";
    userMobileNum = BehaviorSubject<String>();
    userOTP = BehaviorSubject<String>();
    emit(state.copyWith(sendOTPApi: const ApiResponse.completed(0)));
    add(ResetOTPTimer());
  }

  void onClickedReSendOtpButton(
      OnClickReSendOtp event, Emitter<LoginState> emit) {
    emit(state.copyWith(
        sendOTPApi: const ApiResponse.completed(0),
        isResendEnabled: false,
        otpTimer: 60));

    add(OnClickSendOtp());
  }

  // Future<void> _onFormSubmitted(
  //   LoginApi event,
  //   Emitter<LoginStates> emit,
  // ) async {
  //   Map<String, String> data = {
  //     'email': state.email,
  //     'password': state.password,
  //   };
  //   emit(state.copyWith(loginApi: const ApiResponse.loading()));

  //   await authApiRepository.loginApi(data).then((value) async {
  //     if (value.error.isNotEmpty) {
  //       emit(state.copyWith(loginApi: ApiResponse.error(value.error)));
  //     } else {
  //       // await SessionController().saveUserInPreference(value);
  //       // await SessionController().getUserFromPreference();
  //       emit(state.copyWith(loginApi: const ApiResponse.completed('LOGIN')));
  //     }
  //   }).onError((error, stackTrace) {
  //     emit(state.copyWith(loginApi: ApiResponse.error(error.toString())));
  //   });
  // }

  Future<void> onClickedSendOTPButton(
      OnClickSendOtp event, Emitter<LoginState> emit) async {
    emit(state.copyWith(sendOTPApi: const ApiResponse.loading()));
    await otpApiRepository
        .sendOTP({"mobileNo": userMobileNum.value}).then((value) async {
      if (value != null && value.data == 1) {
        emit(state.copyWith(sendOTPApi: ApiResponse.completed(value.data!)));
        add(StartOtpTimer());
      } else {
        emit(state.copyWith(
            sendOTPApi: ApiResponse.error(value!.message ?? "")));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(sendOTPApi: ApiResponse.error(error.toString())));
    });
  }

  Future<void> onClickedVerifyOTPButton(
      OnClickedVerifyOtp event, Emitter<LoginState> emit) async {
    emit(state.copyWith(verifyOTPApi: const ApiResponse.loading()));
    LoadingOverlay.showLoading(context); // Pass context from event
    await otpApiRepository.verifyOTP({
      "mobileNo": userMobileNum.value,
      "otp": userOTP.value
    }).then((value) async {
      if (value != null && value.data == 1) {
        emit(state.copyWith(verifyOTPApi: ApiResponse.completed(value.data!)));
        add(ResetOTPTimer());
        LoadingOverlay.hideLoading();
        await authData.storeAuthData(userMobileNum.value);
        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.home, (route) => false);
        }
      } else {
        emit(state.copyWith(
            verifyOTPApi: ApiResponse.error(value!.message ?? "")));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(verifyOTPApi: ApiResponse.error(error.toString())));
    });
    // Hide loading overlay regardless of success/error
  }
}
