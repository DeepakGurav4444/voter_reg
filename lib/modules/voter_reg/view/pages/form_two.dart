import 'package:flutter/material.dart';
import 'package:voter_reg/modules/voter_reg/blocs/voter_reg_bloc.dart';
import 'package:voter_reg/utils/extensions/general_ectensions.dart';
import 'package:voter_reg/modules/voter_reg/view/registeration_widgets/assembly_drop_field.dart';
import 'package:voter_reg/modules/voter_reg/view/registeration_widgets/caste_drop_field.dart';
import 'package:voter_reg/modules/voter_reg/view/registeration_widgets/category_drop_field.dart';
import 'package:voter_reg/modules/voter_reg/view/registeration_widgets/parliament_drop.dart';
import 'package:voter_reg/modules/voter_reg/view/registeration_widgets/religion_field.dart';
import 'package:voter_reg/modules/voter_reg/view/registeration_widgets/voter_code_field.dart';
import 'package:voter_reg/modules/voter_reg/view/registeration_widgets/voter_id_field.dart';

class FormTwo extends StatelessWidget {
  final VoterRegBloc voterRegBloc;
  const FormTwo({super.key, required this.voterRegBloc});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ReligionDropField(voterRegBloc: voterRegBloc),
          CasteDropField(voterRegBloc: voterRegBloc),
          CategoryDropField(voterRegBloc: voterRegBloc),
          VoterCodeField(voterRegBloc: voterRegBloc),
          ParliamentDropField(voterRegBloc: voterRegBloc),
          AssemblyDropField(voterRegBloc: voterRegBloc),
          VoterIdField(voterRegBloc: voterRegBloc),
          SizedBox(height: context.mediaQueryHeight * 0.5)
        ],
      ),
    );
  }
}