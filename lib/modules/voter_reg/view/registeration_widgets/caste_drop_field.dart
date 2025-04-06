import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/caste_drop_response_model.dart';
import 'package:voter_reg/network_module/response/response.dart';
import 'package:voter_reg/utils/extensions/general_ectensions.dart';

import '../../blocs/voter_reg_bloc.dart';

class CasteDropField extends StatefulWidget {
  const CasteDropField({super.key, required this.voterRegBloc});
  final VoterRegBloc voterRegBloc;

  @override
  State<CasteDropField> createState() => CasteDropFieldState();
}

class CasteDropFieldState extends State<CasteDropField> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoterRegBloc, VoterRegState>(
        buildWhen: (previous, current) =>
            (previous.casteList != current.casteList) ||
            (previous.selectedCaste != current.selectedCaste),
        builder: (context, state) {
          List<CasteData> casteList = state.casteList.status == Status.completed
              ? state.casteList.data!.data!
              : [];
          return StreamBuilder<CasteData>(
              stream: widget.voterRegBloc.casteDrop(context),
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
                                text: "Select Caste",
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
                            child: DropdownSearch<CasteData>(
                              items: (filter, loadProps) => casteList,
                              compareFn: (CasteData? a, CasteData? b) =>
                                  a?.idCaste ==
                                  b?.idCaste, // Ensure correct comparison
                              itemAsString: (CasteData state) =>
                                  state.casteName!,
                              selectedItem: snapshot.data,
                              onChanged: (CasteData? val) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                context.read<VoterRegBloc>().add(OnCasteChanged(
                                    selectedCasteData:
                                        val ?? CasteData(casteName: "")));
                              },
                              onBeforePopupOpening: (selectedItem) async {
                                if (selectedItem == null &&
                                    casteList.isNotEmpty) {
                                  context.read<VoterRegBloc>().add(
                                        OnCasteChanged(
                                          selectedCasteData:
                                              CasteData(casteName: ""),
                                        ),
                                      );
                                }
                                if (casteList.isNotEmpty) {
                                  return true;
                                } else {
                                  return false;
                                }
                              },
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    hintText: "Select Caste",
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
                                  selectedItem?.casteName ?? "Select Caste",
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
