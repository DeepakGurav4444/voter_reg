import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voter_reg/modules/login/blocs/login_bloc.dart';
import 'package:voter_reg/utils/extensions/general_ectensions.dart';
import 'package:voter_reg/modules/login/view/login_widgets/send_otp_button.dart';
import '../../../../network_module/response/status.dart';
import 'resend_otp_button.dart';

class MobileNumberField extends StatefulWidget {
  const MobileNumberField({super.key, required this.loginBloc});
  final LoginBloc loginBloc;

  @override
  State<MobileNumberField> createState() => _MobileNumberFieldState();
}

class _MobileNumberFieldState extends State<MobileNumberField> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return StreamBuilder<String>(
            stream: widget.loginBloc.mobileNum(context),
            builder: (context, snapshot) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.mediaQueryWidth * 0.01,
                ),
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: widget.loginBloc.changeMobileNum,
                      controller: widget.loginBloc.mobileNumController,
                      enabled: state.sendOTPApi.data == 0 &&
                          state.sendOTPApi.status == Status.completed,
                      decoration: InputDecoration(
                        hintText: "Enter Mobile Number",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: Colors.orange, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: Colors.orange, width: 2.0),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: Colors.orange, width: 2.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: Colors.orange, width: 2.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red, width: 2.0),
                        ),
                        labelText: "Mobile Number",
                        errorText: !snapshot.hasError
                            ? null
                            : snapshot.error.toString(),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter(RegExp("[0-9]"),
                            allow: true),
                        LengthLimitingTextInputFormatter(10)
                      ],
                      keyboardType: TextInputType.number,
                    ),
                    snapshot.hasData &&
                            state.verifyOTPApi.status == Status.completed &&
                            state.verifyOTPApi.data == 0
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: context.mediaQueryWidth * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SendOtpButton(),
                                ResendOtpButton(),
                              ],
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              );
            });
      },
    );
  }
}
