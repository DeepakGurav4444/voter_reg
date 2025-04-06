import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voter_reg/modules/voter_reg/blocs/voter_reg_bloc.dart';
import 'package:voter_reg/utils/extensions/general_ectensions.dart';
import 'package:voter_reg/utils/extensions/voter_id_input_formatter.dart';
import 'package:voter_reg/configs/components/input_field.dart';

class VoterIdField extends StatefulWidget {
  const VoterIdField({super.key, required this.voterRegBloc});
  final VoterRegBloc voterRegBloc;

  @override
  State<VoterIdField> createState() => VoterIdFieldState();
}

class VoterIdFieldState extends State<VoterIdField> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
        stream: widget.voterRegBloc.voterId(context),
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
                              "Voter Id", //AppLocalizations.of(context)!.netWeightQTLStr,
                          style: TextStyle(
                            color:
                                Colors.black, // Set the asterisk color to red
                            fontSize: context.mediaQueryWidth * 0.03,
                          ),
                        ),
                        TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red, // Set the asterisk color to red
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
                    onChanged: widget.voterRegBloc.changeVoterId,
                    textEditingController:
                        widget.voterRegBloc.voterIdController,
                    hintText:
                        "Enter Voter Id", //AppLocalizations.of(context)!.loginMobileHintStr,
                    filteringTextInputFormatter: VoterIdInputFormatter(),
                    lengthLimitingTextInputFormatter:
                        LengthLimitingTextInputFormatter(10),
                    textInputType: TextInputType.text,
                    errSnapshot: snapshot,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
