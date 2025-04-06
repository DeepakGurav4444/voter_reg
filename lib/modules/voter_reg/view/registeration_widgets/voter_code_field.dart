import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voter_reg/modules/voter_reg/blocs/voter_reg_bloc.dart';
import 'package:voter_reg/utils/extensions/general_ectensions.dart';
import 'package:voter_reg/configs/components/input_field.dart';

import '../../../../utils/extensions/refer_code_input_formatter.dart';

class VoterCodeField extends StatefulWidget {
  const VoterCodeField({super.key, required this.voterRegBloc});
  final VoterRegBloc voterRegBloc;

  @override
  State<VoterCodeField> createState() => VoterCodeFieldState();
}

class VoterCodeFieldState extends State<VoterCodeField> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
        stream: widget.voterRegBloc.voterCode(context),
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.only(top: context.mediaQueryWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: context.mediaQueryWidth * 0.025),
                  child: RichText(
                    text: TextSpan(
                      style:
                          TextStyle(fontSize: context.mediaQueryWidth * 0.03),
                      children: [
                        TextSpan(
                          text:
                              "Voter Code", //AppLocalizations.of(context)!.netWeightQTLStr,
                          style: TextStyle(
                            color:
                                Colors.black, // Set the asterisk color to red
                            fontSize: context.mediaQueryWidth * 0.03,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: context.mediaQueryWidth * 0.025),
                  child: InputField(
                    onChanged: widget.voterRegBloc.changeVoterCode,
                    textEditingController:
                        widget.voterRegBloc.voterCodeController,
                    hintText:
                        "Enter Voter Code", //AppLocalizations.of(context)!.loginMobileHintStr,
                    filteringTextInputFormatter: ReferCodeInputFormatter(),
                    lengthLimitingTextInputFormatter:
                        LengthLimitingTextInputFormatter(8),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.characters,
                    errSnapshot: snapshot,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
