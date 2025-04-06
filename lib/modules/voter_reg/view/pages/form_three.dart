import 'package:flutter/material.dart';
import 'package:voter_reg/modules/voter_reg/blocs/voter_reg_bloc.dart';
import 'package:voter_reg/utils/extensions/general_ectensions.dart';
import 'package:voter_reg/modules/voter_reg/view/registeration_widgets/address_line1.dart';
import 'package:voter_reg/modules/voter_reg/view/registeration_widgets/address_line2.dart';

import '../registeration_widgets/district_drop_field.dart';
import '../registeration_widgets/state_drop.dart';
import '../registeration_widgets/zilla_field.dart';
class FormThree extends StatelessWidget {
  final VoterRegBloc voterRegBloc;
  const FormThree({super.key, required this.voterRegBloc});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AddressLine1Field(voterRegBloc: voterRegBloc),
          AddressLine2Field(voterRegBloc: voterRegBloc),
          ZillaField(voterRegBloc: voterRegBloc), 
          StateDropField(voterRegBloc: voterRegBloc),
          DistrictDropField(voterRegBloc: voterRegBloc),  
          SizedBox(height: context.mediaQueryHeight * 0.5)
        ],
      ),
    );
  }
}
