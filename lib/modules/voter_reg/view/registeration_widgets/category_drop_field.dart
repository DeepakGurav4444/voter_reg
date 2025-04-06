import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voter_reg/network_module/response/response.dart';
import 'package:voter_reg/utils/extensions/general_ectensions.dart';
import '../../blocs/voter_reg_bloc.dart';
import '../../models/response_models/category_drop_response_model.dart';

class CategoryDropField extends StatefulWidget {
  const CategoryDropField({super.key, required this.voterRegBloc});
  final VoterRegBloc voterRegBloc;

  @override
  State<CategoryDropField> createState() => CasteDropFieldState();
}

class CasteDropFieldState extends State<CategoryDropField> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoterRegBloc, VoterRegState>(
        buildWhen: (previous, current) =>
            (previous.categoryList != current.categoryList) ||
            (previous.selectedCategory != current.selectedCategory),
        builder: (context, state) {
          List<CategoryData> categoryList =
              state.categoryList.status == Status.completed
                  ? state.categoryList.data!.data!
                  : [];
          return StreamBuilder<CategoryData>(
              stream: widget.voterRegBloc.categoryDrop(context),
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
                                text: "Select Category",
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
                            child: DropdownSearch<CategoryData>(
                              items: (filter, loadProps) => categoryList,
                              compareFn: (CategoryData? a, CategoryData? b) =>
                                  a?.idCategory ==
                                  b?.idCategory, // Ensure correct comparison
                              itemAsString: (CategoryData state) =>
                                  state.categoryName!,
                              selectedItem: snapshot.data,
                              onChanged: (CategoryData? val) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                context.read<VoterRegBloc>().add(
                                    OnCategoryChanged(
                                        selectedCategoryData: val ??
                                            CategoryData(categoryName: "")));
                              },
                              onBeforePopupOpening: (selectedItem) async {
                                if (selectedItem == null &&
                                    categoryList.isNotEmpty) {
                                  context.read<VoterRegBloc>().add(
                                        OnCategoryChanged(
                                          selectedCategoryData:
                                              CategoryData(categoryName: ""),
                                        ),
                                      );
                                }
                                if (categoryList.isNotEmpty) {
                                  return true;
                                } else {
                                  return false;
                                }
                              },
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    hintText: "Select Category",
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
                                  selectedItem?.categoryName ??
                                      "Select Category",
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
