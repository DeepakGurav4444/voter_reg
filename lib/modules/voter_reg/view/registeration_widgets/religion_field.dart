import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/religion_drop_response_model.dart';
import 'package:voter_reg/network_module/response/response.dart';
import 'package:voter_reg/utils/extensions/general_ectensions.dart';

import '../../blocs/voter_reg_bloc.dart';

class ReligionDropField extends StatefulWidget {
  const ReligionDropField({super.key, required this.voterRegBloc});
  final VoterRegBloc voterRegBloc;

  @override
  State<ReligionDropField> createState() => ReligionDropFieldState();
}

class ReligionDropFieldState extends State<ReligionDropField> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoterRegBloc, VoterRegState>(
        buildWhen: (previous, current) =>
            previous.religionList != current.religionList ||
            previous.selectedReligion != current.selectedReligion,
        builder: (context, state) {
          List<ReligionData> regionList =
              state.religionList.status == Status.completed
                  ? state.religionList.data!.data!
                  : [];
          return StreamBuilder<ReligionData>(
              stream: widget.voterRegBloc.religionDrop(context),
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
                                text: "Select Religion",
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
                            child: DropdownSearch<ReligionData>(
                              items: (filter, loadProps) => regionList,
                              compareFn: (ReligionData? a, ReligionData? b) =>
                                  a?.idReligion ==
                                  b?.idReligion, // Ensure correct comparison
                              itemAsString: (ReligionData state) =>
                                  state.religion!,
                              selectedItem: snapshot.data,
                              onChanged: (ReligionData? val) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                context.read<VoterRegBloc>().add(
                                      OnReligionChanged(
                                        selectedReligionData:
                                            val ?? ReligionData(religion: ""),
                                      ),
                                    );
                              },
                              onBeforePopupOpening: (selectedItem) async {
                                if (selectedItem == null &&
                                    regionList.isNotEmpty) {
                                  context.read<VoterRegBloc>().add(
                                        OnReligionChanged(
                                          selectedReligionData:
                                              ReligionData(religion: ""),
                                        ),
                                      );
                                }
                                if (regionList.isNotEmpty) {
                                  return true;
                                } else {
                                  return false;
                                }
                              },
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    hintText: "Select Religion",
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
                                  selectedItem?.religion ?? "Select Religion",
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
