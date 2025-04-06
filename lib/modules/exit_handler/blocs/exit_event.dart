part of 'exit_bloc.dart';

abstract class ExitEvent extends Equatable {
  const ExitEvent();

  @override
  List<Object> get props => [];
}

class ExitPressed extends ExitEvent {}
