part of 'voter_reg_bloc.dart';

abstract class VoterRegEvent extends Equatable {
  const VoterRegEvent();

  @override
  List<Object?> get props => [];
}

class OnDatePickerClicked extends VoterRegEvent {
  const OnDatePickerClicked();
  @override
  List<Object> get props => [];
}

class OnRemoveDate extends VoterRegEvent {
  const OnRemoveDate();
  @override
  List<Object> get props => [];
}

class OnVoterRegInitiated extends VoterRegEvent {
  const OnVoterRegInitiated();
  @override
  List<Object> get props => [];
}

class OnStateChanged extends VoterRegEvent {
  final StateData selectedState;
  const OnStateChanged({required this.selectedState});
  @override
  List<Object> get props => [selectedState];
}

class OnDistrictChanged extends VoterRegEvent {
  final DistrictData selectedDistrict;
  const OnDistrictChanged({required this.selectedDistrict});
  @override
  List<Object> get props => [selectedDistrict];
}

class OnParliamentChanged extends VoterRegEvent {
  final ParliamentData? selectedParliament;
  const OnParliamentChanged({this.selectedParliament});
  @override
  List<Object?> get props => [selectedParliament];
}

class OnAssemblyChanged extends VoterRegEvent {
  final AssemblyData? selectedAssemblyData;
  const OnAssemblyChanged({this.selectedAssemblyData});
  @override
  List<Object?> get props => [selectedAssemblyData];
}

class OnReligionChanged extends VoterRegEvent {
  final ReligionData selectedReligionData;
  const OnReligionChanged({required this.selectedReligionData});
  @override
  List<Object?> get props => [selectedReligionData];
}

class OnCasteChanged extends VoterRegEvent {
  final CasteData selectedCasteData;
  const OnCasteChanged({required this.selectedCasteData});
  @override
  List<Object?> get props => [selectedCasteData];
}

class OnCategoryChanged extends VoterRegEvent {
  final CategoryData selectedCategoryData;
  const OnCategoryChanged({required this.selectedCategoryData});
  @override
  List<Object?> get props => [selectedCategoryData];
}

class OnClickNext extends VoterRegEvent {
  const OnClickNext();
  @override
  List<Object> get props => [];
}

class OnClickPrevious extends VoterRegEvent {
  const OnClickPrevious();
  @override
  List<Object> get props => [];
}
