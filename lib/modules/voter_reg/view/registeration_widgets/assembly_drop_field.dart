import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/assembly_drop_response_model.dart';
import 'package:voter_reg/network_module/response/response.dart';
import 'package:voter_reg/utils/extensions/general_ectensions.dart';

import '../../blocs/voter_reg_bloc.dart';

class AssemblyDropField extends StatefulWidget {
  const AssemblyDropField({super.key, required this.voterRegBloc});
  final VoterRegBloc voterRegBloc;

  @override
  State<AssemblyDropField> createState() => AssemblyDropFieldState();
}

class AssemblyDropFieldState extends State<AssemblyDropField> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoterRegBloc, VoterRegState>(
        buildWhen: (previous, current) =>
            (previous.assemblyList != current.assemblyList) ||
            (previous.selectedAssembly != current.selectedAssembly),
        builder: (context, state) {
          List<AssemblyData> assemblyList =
              state.assemblyList.status == Status.completed
                  ? state.assemblyList.data!.data!
                  : [];
          return StreamBuilder<AssemblyData?>(
              stream: widget.voterRegBloc.assemblyDrop(context),
              builder: (context, snapshot) {
                debugPrint("${snapshot.data}");
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
                                text: "Select Assembly",
                                style: TextStyle(
                                    fontSize: context.mediaQueryWidth * 0.03,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: context.mediaQueryWidth * 0.025),
                            child: DropdownSearch<AssemblyData>(
                                items: (filter, loadProps) => assemblyList,
                                compareFn: (AssemblyData? a, AssemblyData? b) =>
                                    a?.idAssemblyData ==
                                    b
                                        ?.idAssemblyData, // Ensure correct comparison
                                itemAsString: (AssemblyData state) =>
                                    state.assemblyName!,
                                selectedItem: snapshot.data,
                                onChanged: (AssemblyData? val) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  context.read<VoterRegBloc>().add(
                                      OnAssemblyChanged(
                                          selectedAssemblyData: val));
                                },
                                popupProps: PopupProps.menu(
                                  showSearchBox: true,
                                  searchFieldProps: TextFieldProps(
                                    decoration: InputDecoration(
                                      hintText: "Select Assembly",
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
                                    selectedItem?.assemblyName ??
                                        "Select Assembly",
                                    style: TextStyle(
                                      fontSize: context.mediaQueryWidth * 0.04,
                                      color: selectedItem == null
                                          ? Colors.black
                                          : Colors.black,
                                    ),
                                  );
                                },
                                onBeforePopupOpening: (selectedItem) async {
                                  if (assemblyList.isNotEmpty) {
                                    return true;
                                  } else {
                                    return false;
                                  }
                                }),
                          ),
                        ]));
              });
        });
  }
}
