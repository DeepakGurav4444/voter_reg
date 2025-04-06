import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voter_reg/configs/components/loading_widget.dart';
import 'package:voter_reg/modules/home/widgets/icon_with_data.dart';
import 'package:voter_reg/utils/extensions/general_ectensions.dart';

import '../../../network_module/response/response.dart';
import '../blocs/home_bloc.dart';
import '../widgets/label_with_data.dart';

class VoterListWidget extends StatelessWidget {
  const VoterListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => state.voterListApi.status == Status.loading
          ? LoadingWidget(size: context.mediaQueryWidth * 0.1)
          : state.voterListApi.status == Status.completed
              ? (state.voterListApi.data!.data ?? []).isEmpty
                  ? Center(
                      child: Container(
                        padding:
                            EdgeInsets.all(context.mediaQueryWidth * 0.025),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Text(
                          "Voters not registered",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: context.mediaQueryWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.all(context.mediaQueryHeight * 0.01),
                      itemCount: state.voterListApi.data!.data!.length,
                    separatorBuilder: (context, index) => SizedBox(height: context.mediaQueryWidth*0.025,),
                      itemBuilder: (context, index) => Material(
                        color: Colors.white24, // Ensure Material background
                        borderRadius: BorderRadius.circular(10),
                        elevation: 4,
                        child: ListTile(
                          dense: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.zero,
                          title: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconWithData(
                                      iconData: Icons.person_2_outlined,
                                      data:
                                          "${state.voterListApi.data!.data?[index].firstName} ${state.voterListApi.data!.data?[index].lastName}"),
                                  IconWithData(
                                      iconData: Icons.badge_outlined,
                                      data:
                                          "${state.voterListApi.data!.data?[index].voterId}"),
                                ],
                              ),
                              LabelWithData(
                                data:
                                    "${state.voterListApi.data!.data?[index].mobileNo}",
                                label: "Mobile No",
                              ),
                              LabelWithData(
                                  label: "Date of Birth",
                                  data:
                                      "${state.voterListApi.data!.data?[index].dob}"),
                            ],
                          ),
                          onTap: () => context.read<HomeBloc>().add(
                              OnClickedListItem(
                                  voterData:
                                      state.voterListApi.data!.data![index])),
                        ),
                      ),
                    )
              : state.voterListApi.status == Status.error
                  ? Center(
                      child: Text(state.voterListApi.message.toString()),
                    )
                  : SizedBox(),
    );
  }
}
