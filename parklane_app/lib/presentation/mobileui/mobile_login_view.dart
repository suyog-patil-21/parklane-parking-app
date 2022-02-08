import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parklane_app/business_logic/switch_login_signup_bloc/switchloginsignupui_bloc.dart';
import 'package:parklane_app/presentation/widgets/custom/ui_design/custom_wave_ui_design.dart';

class MobileLoginView extends StatelessWidget {
  const MobileLoginView({Key? key}) : super(key: key);

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
          ClipPath(
            clipper: LoginWaveUiDesignClipper(),
            child: Container(
              color: Colors.amber.shade200,
              width: double.infinity,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 6),
              height: screenSize.height * 0.5,
              child: Text(
                'Welcome\nBack',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
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
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            hintText: 'Enter your Email',
                            suffixIcon: Icon(Icons.check)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          obscureText: true,
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
                      ElevatedButton(
                        onPressed: () {
                          print("You are Login in ");
                        },
                        child: const Text(
                          'Log in',
                        ),
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(
                                Size(screenSize.width - 0.1, 50))),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: const [
                          Expanded(
                            child: Divider(
                              thickness: 2,
                              endIndent: 10,
                              indent: 2,
                            ),
                          ),
                          Text('or'),
                          Expanded(
                            child:
                                Divider(thickness: 2, endIndent: 2, indent: 10),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  width: 2,
                                  color: Theme.of(context).colorScheme.primary),
                              minimumSize: Size(screenSize.width - 0.1, 50)),
                          onPressed: () {
                            context
                                .read<SwitchloginsignupuiBloc>()
                                .add(SignUpSwitchEvent());
                          },
                          child: const Text(
                            'Sign Up',
                          ))
                    ],
                  ),
                ),
              ))
        ],
      )),
    );
  }
}
