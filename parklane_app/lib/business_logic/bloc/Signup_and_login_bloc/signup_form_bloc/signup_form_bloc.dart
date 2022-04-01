import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../../data/repository/auth_repository.dart';
import '../form_submission_status.dart';
part 'signup_form_event.dart';
part 'signup_form_state.dart';

class SignupFormBloc extends Bloc<SignupFormEvent, SignupFormState> {
  AuthRepository authRepository;
  SignupFormBloc({required this.authRepository})
      : super(const SignupFormState()) {
    on<SignupUsernameChangeEvent>(
        (event, emit) => emit(state.copyWith(username: event.username)));
    on<SigupEmailChangeEvent>(
        (event, emit) => emit(state.copyWith(email: event.email)));
    on<SignupPasswordChangeEvent>(
        ((event, emit) => emit(state.copyWith(password: event.password))));
    on<SignupSubmitedEvent>(_onSignupSubmitEvent);
    on<ToggleSignupVisibility>(
        (event, emit) => emit(state.copyWith(isvisible: !state.isvisible)));
    on<SignupInitEvent>((event, emit) {
      emit(state.copyWith(formStatus: const InitialFormStatus()));
    });
  }

  void _onSignupSubmitEvent(event, emit) async {
    emit(state.copyWith(formStatus: FormSubmmitingStatus()));
    try {
      await authRepository.signup(
          username: state.username.trim(),
          email: state.email.trim(),
          password: state.password);
      emit(state.copyWith(formStatus: FormSubmmisionSuccessStatus()));
    } catch (err) {
      emit(state.copyWith(
          formStatus:
              FormSubmissionFailedStatus(errorMessage: err.toString())));
    }
  }
}
