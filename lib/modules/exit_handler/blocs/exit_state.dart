part of 'exit_bloc.dart';

abstract class ExitState extends Equatable {
  const ExitState();

  @override
  List<Object> get props => [];
}

class ExitInitial extends ExitState {}

class ExitWarning extends ExitState {} // Show toast/snackbar

class ExitConfirmed extends ExitState {} // Exit app
