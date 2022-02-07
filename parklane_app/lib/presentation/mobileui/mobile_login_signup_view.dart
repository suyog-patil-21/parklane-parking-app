import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MobileLoginSignupView extends StatelessWidget {
  static const String route = '/mobileauth';
  const MobileLoginSignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
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
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 6),
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
                    margin: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.mail),
                              suffixIcon: Icon(Icons.check)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.password),
                                suffixIcon: Icon(Icons.visibility))),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Forget Password?'),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text(
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
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 2,
                                endIndent: 10,
                                indent: 2,
                              ),
                            ),
                            Text('or'),
                            Expanded(
                              child: Divider(
                                  thickness: 2, endIndent: 2, indent: 10),
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
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                minimumSize: Size(screenSize.width - 0.1, 50)),
                            onPressed: () {},
                            child: Text(
                              'Sign Up',
                            ))
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class LoginWaveUiDesignClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);

    path.quadraticBezierTo(size.width * 0.15, size.height * 0.8,
        size.width * 0.55, size.height * 0.90);
    path.quadraticBezierTo(
        size.width * 0.79, size.height, size.width, size.height * 0.85);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
