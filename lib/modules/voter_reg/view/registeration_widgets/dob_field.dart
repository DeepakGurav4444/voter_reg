import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voter_reg/modules/voter_reg/blocs/voter_reg_bloc.dart';
import 'package:voter_reg/utils/extensions/general_ectensions.dart';

import '../../../../utils/extensions/date_input_formatter.dart';
import '../../../../configs/components/input_field.dart';

class DOBField extends StatefulWidget {
  const DOBField({super.key, required this.voterRegBloc});
  final VoterRegBloc voterRegBloc;

  @override
  State<DOBField> createState() => DOBFieldState();
}

class DOBFieldState extends State<DOBField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.mediaQueryWidth * 0.05),
      child: StreamBuilder<String>(
        stream: widget.voterRegBloc.dob(context),
        builder: (context, snapshot) =>
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.only(left: context.mediaQueryWidth * 0.025),
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: context.mediaQueryWidth * 0.03),
                children: [
                  TextSpan(
                    text:
                        "Date of Birth", //AppLocalizations.of(context)!.dispatchDateStr,
                    style: TextStyle(
                      color: Colors.black, // Set the asterisk color to red
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
          BlocBuilder<VoterRegBloc, VoterRegState>(
            builder: (context, state) =>
                //Card(
                //       elevation: 5,
                //       shadowColor: Colors.black,
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(20)),
                //       child: InkWell(
                //         onTap: () => context
                //             .read<VoterRegBloc>()
                //             .add(const OnDatePickerClicked()),
                //         child: Row(
                //           children: [
                //             Container(
                //               width: context.mediaQueryWidth * 0.74,
                //               height: context.mediaQueryWidth * 0.13,
                //               padding: EdgeInsets.only(
                //                   left: context.mediaQueryWidth * 0.025),
                //               alignment: Alignment.centerLeft,
                //               decoration: const BoxDecoration(),
                //               child: Text(
                //                 snapshot.hasData && snapshot.data!.isNotEmpty
                //                     ? "${snapshot.data}"
                //                     : "Select Date of Birth",
                //                 // AppLocalizations.of(context)!.selcetStr(
                //                 //     AppLocalizations.of(context)!
                //                 //         .dispatchDateStr),
                //                 style: TextStyle(
                //                     fontSize: context.mediaQueryWidth * 0.04,
                //                     color: Colors.black),
                //               ),
                //             ),
                //             snapshot.hasData && snapshot.data!.isNotEmpty
                //                 ? IconButton(
                //                     onPressed: () => context.read<VoterRegBloc>().add(const OnRemoveDate()),
                //                     icon: const Icon(Icons.clear))
                //                 : IconButton(
                //                     onPressed: () => context
                //                         .read<VoterRegBloc>()
                //                         .add(const OnDatePickerClicked()),
                //                     icon: Icon(Icons.date_range_outlined),
                //                   ),
                //           ],
                //         ),
                //       )),
                // ),
                // snapshot.hasError
                //     ? Align(
                //         alignment: Alignment.centerLeft,
                //         child: Padding(
                //           padding: EdgeInsets.only(
                //               top: context.mediaQueryWidth * 0.005),
                //           child: Text(
                //             snapshot.error.toString(),
                //             style: TextStyle(
                //                 fontWeight: FontWeight.w400,
                //                 fontSize: context.mediaQueryWidth * 0.035,
                //                 color: Colors.red),
                //           ),
                //         ),
                //       )
                //     : const SizedBox(
                //         height: 0,
                //         width: 0,
                //       ),
                Padding(
              padding: EdgeInsets.only(left: context.mediaQueryWidth * 0.025),
              child: InputField(
                onChanged: widget.voterRegBloc.changeDOB,
                textEditingController: widget.voterRegBloc.dOBController,
                hintText:
                    "Select Date of Birth", //AppLocalizations.of(context)!.loginMobileHintStr,
                filteringTextInputFormatter: DateInputFormatter(),
                lengthLimitingTextInputFormatter:
                    LengthLimitingTextInputFormatter(20),
                textInputType: TextInputType.text,
                errSnapshot: snapshot,
                selectDate: () => context
                    .read<VoterRegBloc>()
                    .add(const OnDatePickerClicked()),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
