import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/district_drop_response_model.dart';
import 'package:voter_reg/network_module/response/response.dart';
import 'package:voter_reg/utils/extensions/general_ectensions.dart';

import '../../blocs/voter_reg_bloc.dart';

class DistrictDropField extends StatefulWidget {
  const DistrictDropField({super.key, required this.voterRegBloc});
  final VoterRegBloc voterRegBloc;

  @override
  State<DistrictDropField> createState() => DistrictDropFieldState();
}

class DistrictDropFieldState extends State<DistrictDropField> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoterRegBloc, VoterRegState>(
        buildWhen: (previous, current) =>
            (previous.districtList != current.districtList) ||
            (previous.selectedDistrict != current.selectedDistrict),
        builder: (context, state) {
          List<DistrictData> districtList =
              state.districtList.status == Status.completed
                  ? state.districtList.data!.data!
                  : [];
          return StreamBuilder<DistrictData>(
              stream: widget.voterRegBloc.districtDrop(context),
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
                              text: "Select District",
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
                          child: DropdownSearch<DistrictData>(
                            items: (filter, loadProps) => districtList,
                            compareFn: (DistrictData? a, DistrictData? b) =>
                                a?.idDistrictMaster ==
                                b?.idDistrictMaster, // Ensure correct comparison
                            itemAsString: (DistrictData state) =>
                                state.districtName!,
                            selectedItem: snapshot.data,
                            onChanged: (DistrictData? val) {
                              FocusScope.of(context)
                                  .requestFocus(FocusNode());
                              context.read<VoterRegBloc>().add(
                                    OnDistrictChanged(
                                      selectedDistrict: val ??
                                          DistrictData(districtName: ""),
                                    ),
                                  );
                            },
                            onBeforePopupOpening: (selectedItem) async {
                              if (selectedItem == null &&
                                  districtList.isNotEmpty) {
                                widget.voterRegBloc.changeDistrict(
                                    DistrictData(districtName: ""));
                              }
                              if (districtList.isNotEmpty) {
                                return true;
                              } else {
                                return false;
                              }
                            },
                            popupProps: PopupProps.menu(
                              showSearchBox: true,
                              searchFieldProps: TextFieldProps(
                                decoration: InputDecoration(
                                  hintText: "Select District",
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
                                selectedItem?.districtName ??
                                    "Select District",
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
                      ],
                    ));
              });
        });
  }
}
