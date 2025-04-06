import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'obsecure_field_event.dart';
part 'obsecure_field_state.dart';

class ObsecureFieldBloc extends Bloc<ObsecureFieldEvent, ObsecureFieldState> {
  ObsecureFieldBloc() : super(ObsecureFieldState(isFieldVisible: false)) {
    on<ToggleFieldVisibility>((event, emit) {
      emit(state.copyWith(isFieldVisible: !state.isFieldVisible));
    });
  }
}
