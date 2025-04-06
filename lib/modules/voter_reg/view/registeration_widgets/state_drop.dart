import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/state_drop_response_model.dart';
import 'package:voter_reg/network_module/response/response.dart';
import 'package:voter_reg/utils/extensions/general_ectensions.dart';

import '../../blocs/voter_reg_bloc.dart';

class StateDropField extends StatefulWidget {
  const StateDropField({super.key, required this.voterRegBloc});
  final VoterRegBloc voterRegBloc;

  @override
  State<StateDropField> createState() => StateDropFieldState();
}

class StateDropFieldState extends State<StateDropField> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoterRegBloc, VoterRegState>(
        buildWhen: (previous, current) =>
            (previous.statesList != current.statesList) ||
            (previous.selectedState != current.selectedState),
        builder: (context, state) {
          List<StateData> stateList =
              state.statesList.status == Status.completed
                  ? state.statesList.data!.data!
                  : [];
          return StreamBuilder<StateData>(
              stream: widget.voterRegBloc.stateDrop(context),
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
                                text: "Select State",
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
                            child: DropdownSearch<StateData>(
                              items: (filter, loadProps) => stateList,
                              compareFn: (StateData? a, StateData? b) =>
                                  a?.idStateMaster ==
                                  b?.idStateMaster, // Ensure correct comparison
                              itemAsString: (StateData state) =>
                                  state.stateName!,
                              selectedItem: snapshot.data,
                              onChanged: (StateData? val) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                context.read<VoterRegBloc>().add(OnStateChanged(
                                    selectedState:
                                        val ?? StateData(stateName: "")));
                              },
                              onBeforePopupOpening: (selectedItem) async {
                                if (selectedItem == null &&
                                    stateList.isNotEmpty) {
                                  context.read<VoterRegBloc>().add(
                                        OnStateChanged(
                                          selectedState:
                                              StateData(stateName: ""),
                                        ),
                                      );
                                }
                                if (stateList.isNotEmpty) {
                                  return true;
                                } else {
                                  return false;
                                }
                              },
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    hintText: "Select State",
                                  ),
                                ),
                              ),
                              decoratorProps: const DropDownDecoratorProps(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                              dropdownBuilder: (context, selectedItem) {
                                return Text(
                                  selectedItem?.stateName ?? "Select State",
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
                          if (snapshot.hasError)
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: context.mediaQueryHeight * 0.01),
                                child: Text(
                                  snapshot.error.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: context.mediaQueryWidth * 0.035,
                                      color: Colors.red),
                                ),
                              ),
                            )
                          else
                            const SizedBox(
                              height: 0,
                              width: 0,
                            ),
                        ]));
              });
        });
  }
}
