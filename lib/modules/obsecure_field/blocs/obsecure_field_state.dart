part of 'obsecure_field_bloc.dart';

class ObsecureFieldState extends Equatable {
final bool isFieldVisible;

  const ObsecureFieldState({required this.isFieldVisible});

  ObsecureFieldState copyWith({bool? isFieldVisible}) {
    return ObsecureFieldState(
      isFieldVisible: isFieldVisible ?? this.isFieldVisible,
    );
  }
  
  @override
  List<Object?> get props => [isFieldVisible];
}
