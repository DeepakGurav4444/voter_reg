import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voter_reg/modules/login/blocs/login_bloc.dart';
import 'package:voter_reg/utils/extensions/general_ectensions.dart';

class VerifyOtpButton extends StatefulWidget {
  const VerifyOtpButton({super.key});

  @override
  State<VerifyOtpButton> createState() => _VerifyOtpButtonState();
}

class _VerifyOtpButtonState extends State<VerifyOtpButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
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
            onPressed: () =>
                context.read<LoginBloc>().add(OnClickedVerifyOtp()),
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
                constraints: const BoxConstraints(minWidth: 150, minHeight: 50),
                alignment: Alignment.center,
                child: Text(
                  "Verify OTP",
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
