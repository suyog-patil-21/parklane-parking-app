import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'switchloginsignupui_event.dart';
part 'switchloginsignupui_state.dart';

class SwitchloginsignupuiBloc
    extends Bloc<SwitchloginsignupuiEvent, SwitchloginsignupuiState> {
  SwitchloginsignupuiBloc() : super(LoginState()) {
    on<LoginSwitchEvent>((event, emit) => emit(LoginState()));
    on<SignUpSwitchEvent>((event, emit) => emit(SignUpState()));
  }
}
