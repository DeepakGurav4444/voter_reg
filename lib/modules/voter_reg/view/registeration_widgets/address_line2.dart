import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voter_reg/modules/voter_reg/blocs/voter_reg_bloc.dart';
import 'package:voter_reg/utils/extensions/general_ectensions.dart';
import 'package:voter_reg/configs/components/input_field.dart';

class AddressLine2Field extends StatefulWidget {
  const AddressLine2Field({super.key, required this.voterRegBloc});
  final VoterRegBloc voterRegBloc;

  @override
  State<AddressLine2Field> createState() => AddressLin1State();
}

class AddressLin1State extends State<AddressLine2Field> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: widget.voterRegBloc.addressLine2(context),
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.only(top: context.mediaQueryWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: context.mediaQueryWidth * 0.025),
                  child: InputField(
                    maxLines: 2,
                    onChanged: widget.voterRegBloc.changeAddressLine2,
                    textEditingController:
                        widget.voterRegBloc.addressLine2Controller,
                    hintText:
                        "Enter Address Line 2", //AppLocalizations.of(context)!.loginMobileHintStr,
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
