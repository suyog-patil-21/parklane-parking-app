import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';

import '../../../../data/repository/auth_repository.dart';
import '../form_submission_status.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  AuthRepository authRepository;
  LoginFormBloc({required this.authRepository}) : super(LoginFormState()) {
    on<LoginEmailChangeEvent>(
        (event, emit) => emit(state.copyWith(email: state.email)));
    on<LoginPasswordChangeEvent>(
        ((event, emit) => emit(state.copyWith(password: event.password))));
    on<LoginSubmitedEvent>(_onLoginSubmitEvent);
    on<ToggleVisibility>(
        (event, emit) => emit(state.copyWith(isvisible: !state.isvisible)));
  }

  void _onLoginSubmitEvent(
      LoginSubmitedEvent event, Emitter<LoginFormState> emit) async {
    emit(state.copyWith(formStatus: FormSubmmitingStatus()));
    try {
      await authRepository.login(email: state.email, password: state.password);
      emit(state.copyWith(formStatus: FormSubmmisionSuccessStatus()));
    } catch (e) {
      emit(state.copyWith(
          formStatus: FormSubmissionFailedStatus(e as Exception)));
    }
  }
}
