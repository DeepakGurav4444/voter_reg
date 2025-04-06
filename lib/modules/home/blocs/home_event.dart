part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class OnClickedListItem extends HomeEvent {
  final VoterData voterData;
  const OnClickedListItem({required this.voterData});
}

class OnPageInitiated extends HomeEvent {}

class OnClickAddButton extends HomeEvent {}

class OnClickLogoutButton extends HomeEvent {}
