import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voter_reg/modules/voter_reg/blocs/voter_reg_bloc.dart';
import 'package:voter_reg/utils/extensions/general_ectensions.dart';
import 'package:voter_reg/modules/voter_reg/view/pages/form_one.dart';
import 'package:voter_reg/modules/voter_reg/view/pages/form_three.dart';
import 'package:voter_reg/modules/voter_reg/view/pages/form_two.dart';
import 'package:voter_reg/modules/voter_reg/view/registeration_widgets/nav_and_sub_button.dart';
import '../../../../dependency_injection/locator.dart';
import '../../../exit_handler/view/exit_handler.dart';

class VoterRegScreen extends StatefulWidget {
  const VoterRegScreen({super.key});

  @override
  State<VoterRegScreen> createState() => _VoterRegScreenState();
}

class _VoterRegScreenState extends State<VoterRegScreen> {
  late VoterRegBloc voterRegBloc;

  @override
  void initState() {
    voterRegBloc =
        VoterRegBloc(context: context, voterRegApiRepository: getIt());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return ExitHandler(
      onExit: (p0) => Navigator.pop(context),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocProvider(
          create: (context) => voterRegBloc..add(OnVoterRegInitiated()),
          child: Stack(
            children: [
              // Background Image
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/reg_back.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),

              // Main Content (Forms)
              Positioned(
                top: context.mediaQueryHeight * 0.25,
                left: 0,
                right: 0,
                bottom: isKeyboardVisible
                    ? context.mediaQueryHeight * 0.05
                    : context.mediaQueryHeight * 0.05 +
                        context.mediaQueryHeight *
                            0.12, // Adjust bottom space based on keyboard visibility
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.mediaQueryWidth * 0.1),
                  child: PageView(
                    controller: voterRegBloc.regPageController,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      FormOne(voterRegBloc: voterRegBloc),
                      FormTwo(voterRegBloc: voterRegBloc),
                      FormThree(voterRegBloc: voterRegBloc),
                    ],
                  ),
                ),
              ),

              // Bottom Navigation Buttons (only visible when the keyboard is closed)
              if (!isKeyboardVisible)
                Positioned(
                  bottom:
                      context.mediaQueryHeight * 0.1, // Adjust button position
                  left: 0,
                  right: 0,
                  child: NavAndSubButton(voterRegBloc: voterRegBloc),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
