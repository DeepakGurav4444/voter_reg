import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voter_reg/modules/voter_reg/blocs/voter_reg_bloc.dart';
import 'package:voter_reg/utils/extensions/general_ectensions.dart';

class NavAndSubButton extends StatelessWidget {
  final VoterRegBloc voterRegBloc;
  const NavAndSubButton({super.key, required this.voterRegBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.mediaQueryWidth,
      padding: EdgeInsetsDirectional.symmetric(
          horizontal: context.mediaQueryWidth * 0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<VoterRegBloc, VoterRegState>(
              builder: (context, state) => state.currentPage != 0
                  ? TextButton.icon(
                      icon: Icon(Icons.fast_rewind),
                      onPressed: () =>
                          context.read<VoterRegBloc>().add(OnClickPrevious()),
                      label: Text("Previous"),
                      iconAlignment: IconAlignment.start,
                    )
                  : SizedBox()),
          BlocBuilder<VoterRegBloc, VoterRegState>(
            buildWhen: (previous, current) =>
                previous.currentPage != current.currentPage,
            builder: (context, state) => StreamBuilder<bool>(
                stream:
                    voterRegBloc.validateAccToPage(context, state.currentPage),
                builder: (context, snapshot) {
                  debugPrint("Current Page: ${state.currentPage}");
                  debugPrint("Validation Result: ${snapshot.data}");

                  return TextButton.icon(
                    icon: Icon(Icons.fast_forward),
                    onPressed: snapshot.data ?? false
                        ? () => context.read<VoterRegBloc>().add(OnClickNext())
                        : null,
                    label: Text(state.currentPage != 2 ? "Next" : "Submit"),
                    iconAlignment: IconAlignment.end,
                  );
                }),
          )
        ],
      ),
    );
  }
}
