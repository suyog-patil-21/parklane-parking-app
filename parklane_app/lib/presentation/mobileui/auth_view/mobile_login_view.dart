import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../business_logic/bloc/Signup_and_login_bloc/form_submission_status.dart';
import '../../../business_logic/bloc/Signup_and_login_bloc/login_form_bloc/login_form_bloc.dart';
import '../../../business_logic/cubit/login_sign_switch_cubit/loginsignswitch_cubit.dart';
import '../../widgets/custom/ui_design/custom_wave_ui_design.dart';
import '../../widgets/gobals/or_divider_widget.dart';

class MobileLoginView extends StatelessWidget {
  final _loginFormKey = GlobalKey<FormState>();
  MobileLoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return BlocListener<LoginFormBloc, LoginFormState>(
      listener: (context, state) {
        final errorStatus = state.formStatus;
        if (errorStatus is FormSubmissionFailedStatus) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: Text(errorStatus.errorMessage),
                  actions: [
                    TextButton(
                        onPressed: () {
                          context.read<LoginFormBloc>().add(LoginInitEvent());
                          Navigator.pop(context);
                        },
                        child: const Text('OK'))
                  ],
                );
              });
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: screenSize.height * 0.5,
                width: double.infinity,
                child: ClipPath(
                  clipper: LoginWaveUiDesignClipper(),
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/svgs/intro_screen.svg',
                        fit: BoxFit.fitWidth,
                      ),
                      Container(
                        // color: Colors.amber.shade200,
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22, vertical: 6),
                        height: screenSize.height * 0.5,
                        child: Text(
                          'Welcome\nBack',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ],
                  ),
                )),
            Align(
                alignment: Alignment.bottomCenter,
                child: Form(
                  key: _loginFormKey,
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _emailInputField(),
                        const SizedBox(
                          height: 10,
                        ),
                        _passwordInputField(),
                        const SizedBox(
                          height: 5,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _loginSubmitButton(screenSize),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const OrDividerForm(),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      width: 2,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  minimumSize:
                                      Size(screenSize.width - 0.1, 50)),
                              onPressed: () {
                                BlocProvider.of<LoginSignupUISwitchCubit>(
                                        context)
                                    .switchToSignUp();
                              },
                              child: const Text(
                                'Sign Up',
                              )),
                        )
                      ],
                    ),
                  ),
                ))
          ],
        )),
      ),
    );
  }

  Widget _loginSubmitButton(Size screenSize) {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      builder: (context, state) {
        return state.formStatus is FormSubmmitingStatus
            ? const Center(child: CircularProgressIndicator())
            : ElevatedButton(
                onPressed: () {
                  print("You are Login in ");
                  if (_loginFormKey.currentState!.validate()) {
                    context.read<LoginFormBloc>().add(LoginSubmitedEvent());
                  }
                },
                child: const Text(
                  'Log in',
                ),
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(screenSize.width - 0.1, 50))),
              );
      },
    );
  }

  Widget _passwordInputField() {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      builder: (context, state) {
        return TextFormField(
            validator: (value) =>
                state.isValidPassword ? null : 'Enter password empty',
            onChanged: (value) => context
                .read<LoginFormBloc>()
                .add(LoginPasswordChangeEvent(password: value)),
            obscureText: state.isvisible,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.password),
                hintText: 'Enter your Password',
                suffixIcon: GestureDetector(
                    onTap: () {
                      context
                          .read<LoginFormBloc>()
                          .add(ToggleLoginVisibility());
                    },
                    child: state.isvisible
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility))));
      },
    );
  }

  Widget _emailInputField() {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      builder: (context, state) {
        return TextFormField(
            validator: (value) =>
                state.isValidEmail ? null : 'Enter a valid email',
            onChanged: (value) => context
                .read<LoginFormBloc>()
                .add(LoginEmailChangeEvent(email: value)),
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.mail),
                hintText: 'Enter your Email',
                suffixIcon: state.isValidEmail
                    ? const Icon(
                        Icons.check,
                      )
                    : null));
      },
    );
  }
}
