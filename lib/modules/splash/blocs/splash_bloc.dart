import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:voter_reg/configs/routes/routes_name.dart';
import 'package:voter_reg/utils/services/auth_data.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final BuildContext context;
  final AuthData authData;
  SplashBloc({required this.authData, required this.context})
      : super(SplashState()) {
    on<SplashInitialEvent>(onSplashInitialEvent);
  }

  Future<void> onSplashInitialEvent(
      SplashInitialEvent event, Emitter<SplashState> emit) async {
    var isDataExist = await authData.isAuthExist();
    if (context.mounted) {
      if (isDataExist) {
        Navigator.pushNamedAndRemoveUntil(
            context, RoutesName.home, (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, RoutesName.login, (route) => false);
      }
    }
  }
}
