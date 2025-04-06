import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voter_reg/modules/login/blocs/login_bloc.dart';
import 'package:voter_reg/utils/extensions/general_ectensions.dart';
import 'package:voter_reg/modules/login/view/login_widgets/verify_otp_button.dart';

class OTPField extends StatefulWidget {
  final LoginBloc loginBloc;
  const OTPField({super.key, required this.loginBloc});

  @override
  State<OTPField> createState() => _OTPFieldState();
}

class _OTPFieldState extends State<OTPField> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.sendOTPApi.data != current.sendOTPApi.data,
      builder: (context, state) {
        return state.sendOTPApi.data == 1
            ? StreamBuilder<String>(
                stream: widget.loginBloc.otp(context),
                builder: (context, snapshot) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.mediaQueryWidth * 0.01,
                        vertical: context.mediaQueryWidth * 0.05),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: widget.loginBloc.changeUserOTP,
                            controller: widget.loginBloc.otpController,
                            decoration: InputDecoration(
                              hintText: "Enter OTP",
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    BorderSide(color: Colors.green, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    BorderSide(color: Colors.green, width: 2.0),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    BorderSide(color: Colors.green, width: 2.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    BorderSide(color: Colors.green, width: 2.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2.0),
                              ),
                              labelText: "OTP",
                              errorText: !snapshot.hasError
                                  ? null
                                  : snapshot.error.toString(),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter(RegExp("[0-9]"),
                                  allow: true),
                              LengthLimitingTextInputFormatter(4)
                            ],
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        snapshot.hasData ? VerifyOtpButton() : SizedBox()
                      ],
                    ),
                  );
                })
            : SizedBox();
      },
    );
  }
}
