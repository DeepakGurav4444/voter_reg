part of 'obsecure_field_bloc.dart';

abstract class ObsecureFieldEvent extends Equatable {
  const ObsecureFieldEvent();

  @override
  List<Object> get props => [];
}

class ToggleFieldVisibility extends ObsecureFieldEvent {}
