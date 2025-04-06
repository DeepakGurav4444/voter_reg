import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voter_reg/modules/voter_reg/blocs/voter_reg_bloc.dart';
import 'package:voter_reg/utils/extensions/general_ectensions.dart';
import 'package:voter_reg/configs/components/input_field.dart';

class AddressLine1Field extends StatefulWidget {
  const AddressLine1Field({super.key, required this.voterRegBloc});
  final VoterRegBloc voterRegBloc;

  @override
  State<AddressLine1Field> createState() => AddressLin1State();
}

class AddressLin1State extends State<AddressLine1Field> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: widget.voterRegBloc.addressLine1(context),
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
                              "Address", //AppLocalizations.of(context)!.netWeightQTLStr,
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
                    maxLines: 2,
                    onChanged: widget.voterRegBloc.changeAddressLine1,
                    textEditingController:
                        widget.voterRegBloc.addressLine1Controller,
                    hintText:
                        "Enter Address Line 1", //AppLocalizations.of(context)!.loginMobileHintStr,
                    filteringTextInputFormatter: FilteringTextInputFormatter(
                        RegExp(r'^[a-zA-Z0-9\s,.\-#/]*$'),
                        allow: true),
                    lengthLimitingTextInputFormatter:
                        LengthLimitingTextInputFormatter(40),
                    textInputType: TextInputType.text,
                    errSnapshot: snapshot,
                  ),
                )
              ],
            ),
          );
        });
  }
}
