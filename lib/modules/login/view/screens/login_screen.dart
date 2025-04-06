import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voter_reg/modules/login/blocs/login_bloc.dart';
import 'package:voter_reg/utils/extensions/general_ectensions.dart';
import 'package:voter_reg/modules/login/view/login_widgets/otp_field.dart';
import '../../../../dependency_injection/locator.dart';
import '../login_widgets/mobile_number_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc loginBloc;

  @override
  void initState() {
    loginBloc = LoginBloc(context: context, otpApiRepository: getIt(),authData: getIt());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocProvider(
        create: (context) => loginBloc..add(OnLoginPageIntiated()),
        child: Stack(
          children: [
            // Background Image
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/login_back.jpeg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),

            // Main Content (Forms)
            Positioned(
              top: context.mediaQueryHeight * 0.48,
              left: 0,
              right: 0, 
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.mediaQueryWidth * 0.1),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      MobileNumberField(loginBloc: loginBloc),
                      OTPField(loginBloc: loginBloc)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
