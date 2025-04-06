import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voter_reg/modules/login/blocs/login_bloc.dart';
import 'package:voter_reg/configs/components/loading_widget.dart';
import 'package:voter_reg/utils/extensions/flush_bar_extension.dart';
import 'package:voter_reg/utils/extensions/general_ectensions.dart';
import '../../../../network_module/response/status.dart';

class SendOtpButton extends StatefulWidget {
  const SendOtpButton({super.key});

  @override
  State<SendOtpButton> createState() => _SendOtpButtonState();
}

class _SendOtpButtonState extends State<SendOtpButton> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (current, previous) =>
          current.sendOTPApi.status != previous.sendOTPApi.status,
      listener: (context, state) {
        if (state.sendOTPApi.status == Status.error) {
          context.flushBarErrorMessage(
              message: state.sendOTPApi.message.toString());
        }
      },
      builder: (context, state) {
        return Container(
          height: context.mediaQueryWidth * 0.1,
          padding: EdgeInsets.only(left: context.mediaQueryWidth * 0.025),
          width: context.mediaQueryWidth * 0.3,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
            onPressed: () => state.sendOTPApi.data == 1
                ? context.read<LoginBloc>().add(OnClickResetButton())
                : context.read<LoginBloc>().add(OnClickSendOtp()),
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
                constraints:
                    BoxConstraints(minHeight: context.mediaQueryWidth * 0.1),
                alignment: Alignment.center,
                child: state.sendOTPApi.status == Status.loading
                    ? LoadingWidget(
                        size: context.mediaQueryWidth * 0.05,
                      )
                    : Text(
                        state.sendOTPApi.data == 1 ? "Reset" : "Send OTP",
                        style: TextStyle(
                          color: Colors.black, // Text color
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
