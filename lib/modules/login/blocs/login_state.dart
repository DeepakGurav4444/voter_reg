part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState(
      {this.username = '',
      this.password = '',
      this.resendOTPApi = const ApiResponse.completed(0),
      this.sendOTPApi = const ApiResponse.completed(0),
      this.verifyOTPApi = const ApiResponse.completed(0),
      this.isResendEnabled = false,
      this.otpTimer = 60});

  final String username;
  final String password;
  final ApiResponse<int> resendOTPApi;
  final ApiResponse<int> sendOTPApi;
  final ApiResponse<int> verifyOTPApi;
  final int otpTimer; // Timer countdown value
  final bool isResendEnabled; // Flag to enable/disable resend button

  LoginState copyWith(
      {String? username,
      String? password,
      ApiResponse<int>? resendOTPApi,
      ApiResponse<int>? sendOTPApi,
      ApiResponse<int>? verifyOTPApi,
      int? otpTimer,
      bool? isResendEnabled}) {
    return LoginState(
        username: username ?? this.username,
        password: password ?? this.password,
        sendOTPApi: sendOTPApi ?? this.sendOTPApi,
        verifyOTPApi: verifyOTPApi ?? this.verifyOTPApi,
        otpTimer: otpTimer ?? this.otpTimer,
        isResendEnabled: isResendEnabled ?? this.isResendEnabled,
        resendOTPApi: resendOTPApi ?? this.resendOTPApi);
  }

  @override
  List<Object> get props => [
        username,
        password,
        resendOTPApi,
        sendOTPApi,
        verifyOTPApi,
        isResendEnabled,
        resendOTPApi,
        otpTimer
      ];
}
