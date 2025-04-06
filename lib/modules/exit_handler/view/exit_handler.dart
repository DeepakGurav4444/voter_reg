import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../blocs/exit_bloc.dart';

class ExitHandler extends StatelessWidget {
  final Widget child;
  final void Function(BuildContext) onExit;

  const ExitHandler({required this.child, super.key, required this.onExit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExitBloc(), // Provide ExitBloc automatically
      child: BlocListener<ExitBloc, ExitState>(
        listener: (context, state) {
          if (state is ExitWarning) {
            Fluttertoast.showToast(msg: "Press again to go back");
          } else if (state is ExitConfirmed) {
            onExit(context); // Go back to previous screen
          }
        },
        child: BlocBuilder<ExitBloc, ExitState>(
          builder: (context, state) {
            return PopScope(
              canPop: false, // Prevents default pop action
              onPopInvokedWithResult: (didPop, result) {
                if (!didPop) {
                  context.read<ExitBloc>().add(ExitPressed());
                }
              },
              child: child,
            );
          },
        ),
      ),
    );
  }
}
