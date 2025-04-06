part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

class LoginApi extends LoginEvent {
  const LoginApi();
}

class OnLoginPageIntiated extends LoginEvent {
  const OnLoginPageIntiated();
}

class OnClickSendOtp extends LoginEvent {}

class OnClickReSendOtp extends LoginEvent {}

class OnClickResetButton extends LoginEvent {}

class OnClickedVerifyOtp extends LoginEvent {}

class OnOTPSent extends LoginEvent {}

class StartOtpTimer extends LoginEvent {}

class UpdateOtpTimer extends LoginEvent {}

class ResetOTPTimer extends LoginEvent {}
