import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parklane_app/business_logic/bloc/Signup_and_login_bloc/form_submission_status.dart';
import 'package:parklane_app/business_logic/bloc/Signup_and_login_bloc/signup_form_bloc/signup_form_bloc.dart';
import 'package:parklane_app/business_logic/cubit/login_sign_switch_cubit/loginsignswitch_cubit.dart';
import 'package:parklane_app/presentation/widgets/custom/ui_design/custom_wave_ui_design.dart';
import 'package:parklane_app/presentation/widgets/gobals/or_divider_widget.dart';

class MobileSignUpView extends StatelessWidget {
  final _signupFormKey = GlobalKey<FormState>();
  MobileSignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
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
              clipper: SignUpWaveUiDesignClipper(),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 22, vertical: 6),
                    height: screenSize.height * 0.50,
                    child: Text(
                      'Create\nAccount',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Form(
                key: _signupFormKey,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _userNameInputField(),
                      const SizedBox(
                        height: 10,
                      ),
                      _emailInputField(),
                      const SizedBox(
                        height: 10,
                      ),
                      _passwordInputField(),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _signupSubmitButton(screenSize),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const OrDividerForm(),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    width: 2,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                minimumSize: Size(screenSize.width - 0.1, 50)),
                            onPressed: () {
                              BlocProvider.of<LoginSignupUISwitchCubit>(context)
                                  .switchToLogin();
                            },
                            child: const Text(
                              'Log in',
                            )),
                      )
                    ],
                  ),
                ),
              ))
        ],
      )),
    );
  }

  Widget _signupSubmitButton(
    Size screenSize,
  ) {
    return BlocBuilder<SignupFormBloc, SignupFormState>(
      builder: (BuildContext context, state) {
        return state.formStatus is FormSubmmitingStatus
            ? const Center(child: CircularProgressIndicator())
            : ElevatedButton(
                onPressed: () {
                  print("Created Your account");
                  if (_signupFormKey.currentState!.validate()) {
                    context.read<SignupFormBloc>().add(SignupSubmitedEvent());
                  }
                },
                child: const Text(
                  'Sign Up',
                ),
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(screenSize.width - 0.1, 50))),
              );
      },
    );
  }

  Widget _passwordInputField() {
    return BlocBuilder<SignupFormBloc, SignupFormState>(
        builder: (context, state) {
      return TextFormField(
          validator: (value) => state.isValidPassword
              ? null
              : 'Enter password greater than 8 characters',
          onChanged: (value) => context
              .read<SignupFormBloc>()
              .add(SignupPasswordChangeEvent(password: value)),
          obscureText: state.isvisible,
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.password),
              hintText: 'Your password',
              suffixIcon: GestureDetector(
                  onTap: () {
                    context.read<SignupFormBloc>().add(ToggleVisibility());
                  },
                  child: state.isvisible
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off))));
    });
  }

  Widget _emailInputField() {
    return BlocBuilder<SignupFormBloc, SignupFormState>(
        builder: (context, state) {
      return TextFormField(
        validator: (value) => state.isValidEmail ? null : 'Enter a valid email',
        onChanged: (value) => context
            .read<SignupFormBloc>()
            .add(SigupEmailChangeEvent(email: value)),
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.mail),
          hintText: 'Your Email',
        ),
      );
    });
  }

  Widget _userNameInputField() {
    return BlocBuilder<SignupFormBloc, SignupFormState>(
      builder: (context, state) {
        return TextFormField(
            validator: (value) => state.isValidUsername
                ? null
                : 'Enter username greater than 3 digits',
            onChanged: (value) => context
                .read<SignupFormBloc>()
                .add(SignupUsernameChangeEvent(username: value)),
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person), hintText: 'Your Name'));
      },
    );
  }
}
