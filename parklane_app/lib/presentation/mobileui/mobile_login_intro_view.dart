import 'package:flutter/material.dart';
import 'package:parklane_app/presentation/mobileui/mobile_login_signup_view.dart';

class MobileLoginIntroView extends StatelessWidget {
  static const String route = '/mobileauthintro';

  const MobileLoginIntroView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.amberAccent.shade100,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Text(
                'Parklane',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Let\'s Park',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Park your vehicle before Present at the place',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(MobileLoginSignupView.route);
                      },
                      child: Text(
                        'Let\'s Go',
                      ),
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(
                              Size(screenSize.width - 0.1, 50))),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
