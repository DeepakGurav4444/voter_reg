import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voter_reg/modules/login/blocs/login_bloc.dart';
import 'package:voter_reg/utils/extensions/general_ectensions.dart';

import '../../../../configs/components/loading_widget.dart';
import '../../../../network_module/response/status.dart';

class ResendOtpButton extends StatefulWidget {
  const ResendOtpButton({super.key});

  @override
  State<ResendOtpButton> createState() => ResendOtpButtonState();
}

class ResendOtpButtonState extends State<ResendOtpButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.sendOTPApi.data == 1
            ? !state.isResendEnabled
                ? Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Resend OTP in ",
                          style: TextStyle(
                            color: Colors.green, // Text color
                            fontWeight: FontWeight.bold,
                            fontSize: context.mediaQueryWidth * 0.04,
                          ),
                        ),
                        TextSpan(
                          text: "${state.otpTimer}s",
                          style: TextStyle(
                              color: Colors.orange, // Text color
                              fontWeight: FontWeight.bold,
                              fontSize: context.mediaQueryWidth * 0.04),
                        ),
                      ],
                    ),
                  )
                : Container(
                    height: context.mediaQueryWidth * 0.1,
                    padding:
                        EdgeInsets.only(left: context.mediaQueryWidth * 0.025),
                    width: context.mediaQueryWidth * 0.3,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                      onPressed: () =>
                          context.read<LoginBloc>().add(OnClickReSendOtp()),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFFF9933), // Saffron
                              Color(0xFFFFFFFF), // White
                              Color(0xFF138808), // Green
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          constraints: BoxConstraints(
                              minHeight: context.mediaQueryWidth * 0.1),
                          alignment: Alignment.center,
                          child: state.resendOTPApi.status == Status.loading
                              ? LoadingWidget(
                                  size: context.mediaQueryWidth * 0.05,
                                )
                              : Text(
                                  "Resend OTP",
                                  style: TextStyle(
                                    color: Colors.black, // Text color
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  )
            : SizedBox();
      },
    );
  }
}
