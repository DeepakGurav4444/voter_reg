import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'exit_event.dart';
part 'exit_state.dart';

class ExitBloc extends Bloc<ExitEvent, ExitState> {
  DateTime? lastPressed;
  ExitBloc() : super(ExitInitial()) {
    on<ExitEvent>((event, emit) {});

    on<ExitPressed>((event, emit) {
      final now = DateTime.now();
      if (lastPressed == null ||
          now.difference(lastPressed!) > Duration(seconds: 2)) {
        lastPressed = now;
        emit(ExitWarning()); // Show warning message
      } else {
        emit(ExitConfirmed()); // Exit the app
      }
    });
  }
}
