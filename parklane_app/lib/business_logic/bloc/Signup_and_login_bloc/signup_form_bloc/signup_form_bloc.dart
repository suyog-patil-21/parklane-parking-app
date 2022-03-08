import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../data/repository/auth_repository.dart';
import '../form_submission_status.dart';

part 'signup_form_event.dart';
part 'signup_form_state.dart';

class SignupFormBloc extends Bloc<SignupFormEvent, SignupFormState> {
  AuthRepository authRepository;
  SignupFormBloc({required this.authRepository}) : super(SignupFormState()) {
    on<SignupUsernameChangeEvent>(
        (event, emit) => emit(state.copyWith(username: event.username)));
    on<SigupEmailChangeEvent>(
        (event, emit) => emit(state.copyWith(email: state.email)));
    on<SignupPasswordChangeEvent>(
        ((event, emit) => emit(state.copyWith(password: event.password))));
    on<SignupSubmitedEvent>(_onSignupSubmitEvent);
    on<ToggleVisibility>(
        (event, emit) => emit(state.copyWith(isvisible: !state.isvisible)));
  }

  void _onSignupSubmitEvent(event, emit) async {
    emit(state.copyWith(formStatus: FormSubmmitingStatus()));
    try {
      await authRepository.signup(
          username: state.username,
          email: state.email,
          password: state.password);
      emit(state.copyWith(formStatus: FormSubmmisionSuccessStatus()));
    } catch (e) {
      emit(state.copyWith(
          formStatus: FormSubmissionFailedStatus(e as Exception)));
    }
  }
}
