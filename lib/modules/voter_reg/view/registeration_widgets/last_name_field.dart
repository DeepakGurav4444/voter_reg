import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voter_reg/modules/voter_reg/blocs/voter_reg_bloc.dart';
import 'package:voter_reg/utils/extensions/general_ectensions.dart';
import 'package:voter_reg/configs/components/input_field.dart';

class LastNameField extends StatefulWidget {
  const LastNameField({super.key, required this.voterRegBloc});
  final VoterRegBloc voterRegBloc;

  @override
  State<LastNameField> createState() => LastNameFieldState();
}

class LastNameFieldState extends State<LastNameField> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: widget.voterRegBloc.lastName(context),
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
                              "Last Name", //AppLocalizations.of(context)!.netWeightQTLStr,
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
                // Card(
                //   elevation: 5,
                //   shadowColor: Colors.black,
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(20)),
                //   child:
                Padding(
                  padding:
                      EdgeInsets.only(left: context.mediaQueryWidth * 0.025),
                  child: InputField(
                    onChanged: widget.voterRegBloc.changeLastName,
                    textEditingController:
                        widget.voterRegBloc.lastNameController,
                    hintText:
                        "Enter Last Name", //AppLocalizations.of(context)!.loginMobileHintStr,
                    filteringTextInputFormatter: FilteringTextInputFormatter(
                        RegExp("[A-Za-z]"),
                        allow: true),
                    lengthLimitingTextInputFormatter:
                        LengthLimitingTextInputFormatter(20),
                    textInputType: TextInputType.text,
                    errSnapshot: snapshot,
                  ),
                ),
                // )
              ],
            ),
          );
        });
  }
}
