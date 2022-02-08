import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parklane_app/business_logic/switch_login_signup_bloc/switchloginsignupui_bloc.dart';
import 'package:parklane_app/presentation/widgets/custom/ui_design/custom_wave_ui_design.dart';

class MobileSignUpView extends StatelessWidget {
  const MobileSignUpView({Key? key}) : super(key: key);

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
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              hintText: 'Your Name')),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            hintText: 'Your Email',
                            suffixIcon: Icon(Icons.check)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          // TODO : implement show password
                          obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.password),
                              hintText: 'Your password',
                              suffixIcon: Icon(Icons.visibility))),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            print("Created Your account");
                          },
                          child: const Text(
                            'Sign Up',
                          ),
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(screenSize.width - 0.1, 50))),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
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
                              context
                                  .read<SwitchloginsignupuiBloc>()
                                  .add(LoginSwitchEvent());
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
}
