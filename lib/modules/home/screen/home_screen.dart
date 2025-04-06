import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voter_reg/dependency_injection/locator.dart';
import 'package:voter_reg/modules/home/view/voter_list_widget.dart';
import 'package:voter_reg/utils/extensions/general_ectensions.dart';

import '../../exit_handler/view/exit_handler.dart';
import '../blocs/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = HomeBloc(
        homeApiRepository: getIt(), context: context, authData: getIt());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExitHandler(
        onExit: (p0) async {
          Navigator.pop(context);
        },
        child: BlocProvider(
          create: (context) => homeBloc..add(OnPageInitiated()),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return Scaffold(
                // appBar: AppBar(
                //   title: Text(
                //     "Home",
                //     style: TextStyle(
                //         color: Colors.orangeAccent,
                //         fontSize: context.mediaQueryWidth * 0.06,
                //         fontWeight: FontWeight.bold),
                //   ),
                //   actions: [
                //     IconButton(
                //       icon: Icon(
                //         Icons.logout,
                //         size: context.mediaQueryWidth * 0.06,
                //       ),
                //       onPressed: () =>
                //           context.read<HomeBloc>().add(OnClickLogoutButton()),
                //     )
                //   ],
                //   centerTitle: true,
                //   backgroundColor:
                //       Colors.white.withValues(alpha: 0, red: 255, green: 255, blue: 255), // Light transparent effect
                //   surfaceTintColor: Colors.transparent,
                //   elevation: 0,
                // ),
                floatingActionButton: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    return FloatingActionButton.extended(
                      label: Text("Add Voter"),
                      icon: Icon(Icons.add),
                      onPressed: () =>
                          context.read<HomeBloc>().add(OnClickAddButton()),
                    );
                  },
                ),
                body: Stack(
                  children: [
                    // Full-Screen Background Image
                    Positioned.fill(
                      child: Image.asset(
                        "assets/images/login_back.jpeg",
                        fit: BoxFit.cover,
                      ),
                    ),

                    // Transparent AppBar
                    Positioned(
                      top: MediaQuery.of(context)
                          .padding
                          .top, // Avoids overlap with status bar
                      left: 0,
                      right: 0,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withAlpha(30), // Semi-transparent effect
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(40), // Soft shadow
                              blurRadius: 5,
                              spreadRadius: 1,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: context.mediaQueryWidth * 0.38),
                              child: Text(
                                "Home",
                                style: TextStyle(
                                  color: Colors.orangeAccent,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.06,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: context.mediaQueryWidth * 0.1,
                              child: IconButton(
                                icon: Icon(Icons.logout),
                                onPressed: () => context
                                    .read<HomeBloc>()
                                    .add(OnClickLogoutButton()),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // List Widget Positioned Below AppBar
                    Positioned.fill(
                      top: kToolbarHeight + MediaQuery.of(context).padding.top,
                      child: Container(
                        color: Color.fromRGBO(197, 162, 148, 0.8),
                        child: VoterListWidget(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
