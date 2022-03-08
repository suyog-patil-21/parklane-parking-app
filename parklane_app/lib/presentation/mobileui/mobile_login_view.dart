import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/gobals/or_divider_widget.dart';
import 'mobile_signup_view.dart';

import '../../business_logic/cubit/login_sign_switch_cubit/loginsignswitch_cubit.dart';
import '../widgets/custom/ui_design/custom_wave_ui_design.dart';

class MobileLoginView extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  MobileLoginView({Key? key}) : super(key: key);

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
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a Email';
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                              .hasMatch(value)) {
                            return 'Enter a valid Email';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            hintText: 'Enter your Email',
                            suffixIcon: Icon(Icons.check)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter password';
                            } else if (value.length < 8) {
                              return 'Enter password greater than 8 letters';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.password),
                              hintText: 'Enter your Password',
                              suffixIcon: Icon(Icons.visibility))),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text('Forget Password?'),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            print(_emailController.text +
                                " " +
                                _passwordController.text);

                            print("You are Login in ");
                          },
                          child: const Text(
                            'Log in',
                          ),
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(screenSize.width - 0.1, 50))),
                        ),
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
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                minimumSize: Size(screenSize.width - 0.1, 50)),
                            onPressed: () {
                              BlocProvider.of<LoginSignupUISwitchCubit>(context)
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
    );
  }
}
