import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/repository/auth_repository.dart';
import '../form_submission_status.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final AuthRepository authRepository;
  LoginFormBloc({required this.authRepository})
      : super(const LoginFormState()) {
    on<LoginEmailChangeEvent>(
        (event, emit) => emit(state.copyWith(email: event.email)));
    on<LoginPasswordChangeEvent>(
        ((event, emit) => emit(state.copyWith(password: event.password))));
    on<LoginSubmitedEvent>(_onLoginSubmitEvent);
    on<ToggleLoginVisibility>(
        (event, emit) => emit(state.copyWith(isvisible: !state.isvisible)));
    on<LoginInitEvent>(
      (event, emit) {
        emit(state.copyWith(formStatus: const InitialFormStatus()));
      },
    );
  }

  void _onLoginSubmitEvent(
      LoginSubmitedEvent event, Emitter<LoginFormState> emit) async {
    emit(state.copyWith(formStatus: FormSubmmitingStatus()));
    try {
      await authRepository.login(
          email: state.email.trim(), password: state.password);
      emit(state.copyWith(formStatus: FormSubmmisionSuccessStatus()));
    } catch (err) {
      emit(state.copyWith(
          formStatus:
              FormSubmissionFailedStatus(errorMessage: err.toString())));
    }
  }
}
