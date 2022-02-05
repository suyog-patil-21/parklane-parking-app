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
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: screenSize.height * 0.5,
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(
                    screenSize.width,
                    screenSize.height * 0.5,
                  ),
                  painter: CustomLoginUiPainter(),
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 15.0),
                      child: Text(
                        'Welcome\nBack',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ))
              ],
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
                              height: 1,
                              thickness: 2,
                            ),
                          ),
                          Text('or'),
                          Expanded(
                            child: Divider(
                              thickness: 2,
                            ),
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
    );
  }
}

// TODO : Implement Curve here
class CustomLoginUiPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.amber.shade200
      ..style = PaintingStyle.fill;

    Path path = Path()..moveTo(0, 0);
    path.lineTo(0, size.height);
    // path.quadraticBezierTo(size.width * 0.125, size.height * 0.925,
    //     size.width * 0.375, size.height * 0.9);
    // path.quadraticBezierTo(size.width * 0.625, size.height * 0.925,
    //     size.width * 0.75, size.height);
    // path.quadraticBezierTo(
    //     size.width * 0.625, size.height * 0.975, size.width, size.height * 0.9);
    path.lineTo(size.width, size.height * 0.75);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
