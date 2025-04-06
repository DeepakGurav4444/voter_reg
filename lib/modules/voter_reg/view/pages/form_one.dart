import 'package:flutter/material.dart';
import 'package:voter_reg/modules/voter_reg/blocs/voter_reg_bloc.dart';
import '../registeration_widgets/dob_field.dart';
import '../registeration_widgets/email_field.dart';
import '../registeration_widgets/first_name_field.dart';
import '../registeration_widgets/last_name_field.dart';
import '../registeration_widgets/mobile_number_field.dart';

class FormOne extends StatelessWidget {
  final VoterRegBloc voterRegBloc;
  const FormOne({super.key, required this.voterRegBloc});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FirstNameField(voterRegBloc: voterRegBloc),
          LastNameField(voterRegBloc: voterRegBloc),
          MobileNumberField(voterRegBloc: voterRegBloc),
          DOBField(voterRegBloc: voterRegBloc),
          EmailField(voterRegBloc: voterRegBloc),
          // SizedBox(height: context.mediaQueryHeight*0.5),
        ],
      ),
    );
  }
}
