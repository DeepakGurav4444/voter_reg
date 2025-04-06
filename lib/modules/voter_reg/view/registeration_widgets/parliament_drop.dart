import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/parliament_drop_response_model.dart';
import 'package:voter_reg/network_module/response/response.dart';
import 'package:voter_reg/utils/extensions/general_ectensions.dart';

import '../../blocs/voter_reg_bloc.dart';

class ParliamentDropField extends StatefulWidget {
  const ParliamentDropField({super.key, required this.voterRegBloc});
  final VoterRegBloc voterRegBloc;

  @override
  State<ParliamentDropField> createState() => ParliamentDropFieldState();
}

class ParliamentDropFieldState extends State<ParliamentDropField> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoterRegBloc, VoterRegState>(
        buildWhen: (previous, current) =>
            (previous.parliamentList != current.parliamentList) ||
            (previous.selectedParliament != current.selectedParliament),
        builder: (context, state) {
          List<ParliamentData> parliamentList =
              state.parliamentList.status == Status.completed
                  ? state.parliamentList.data!.data!
                  : [];
          return StreamBuilder<ParliamentData?>(
              stream: widget.voterRegBloc.parliamentDrop(context),
              builder: (context, snapshot) {
                return Padding(
                    padding:
                        EdgeInsets.only(top: context.mediaQueryWidth * 0.05),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: context.mediaQueryWidth * 0.025),
                            child: RichText(
                              text: TextSpan(
                                text: "Select Parliament",
                                style: TextStyle(
                                    fontSize: context.mediaQueryWidth * 0.03,
                                    color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: '*',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: context.mediaQueryWidth * 0.025),
                            child: DropdownSearch<ParliamentData>(
                              items: (filter, loadProps) => parliamentList,
                              compareFn: (ParliamentData? a,
                                      ParliamentData? b) =>
                                  a?.idParliamentData ==
                                  b?.idParliamentData, // Ensure correct comparison
                              itemAsString: (ParliamentData state) =>
                                  state.parliamentName!,
                              selectedItem: snapshot.data,
                              onChanged: (ParliamentData? val) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                context.read<VoterRegBloc>().add(
                                    OnParliamentChanged(
                                        selectedParliament: val));
                              },
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    hintText: "Select Parliament",
                                  ),
                                ),
                              ),
                              onBeforePopupOpening: (selectedItem) async {
                                context.read<VoterRegBloc>().add(
                                      OnParliamentChanged(
                                        selectedParliament: selectedItem,
                                      ),
                                    );
                                if (parliamentList.isNotEmpty) {
                                  return true;
                                } else {
                                  return false;
                                }
                              },
                              decoratorProps: const DropDownDecoratorProps(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                              dropdownBuilder: (context, selectedItem) {
                                return Text(
                                  selectedItem?.parliamentName ??
                                      "Select Parliament",
                                  style: TextStyle(
                                    fontSize: context.mediaQueryWidth * 0.04,
                                    color: selectedItem == null
                                        ? Colors.black
                                        : Colors.black,
                                  ),
                                );
                              },
                            ),
                          ),
                        ]));
              });
        });
  }
}
