import 'package:flutter/material.dart';
import '../widgets/bottom_search_bar.dart';
import '../widgets/floating_custom_home.dart';

class MobileHomeView extends StatelessWidget {
  const MobileHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: CustomBottomSearchBar(screenSize: screenSize),
      floatingActionButton: CustomFloatingButton(screenSize: screenSize),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: screenSize.height * 0.90,
            decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(42),
                    bottomRight: Radius.circular(42))),
          ),

          //FLoating list Display
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(3),
              height: 150,
              // color: Colors.yellowAccent,
              child: PageView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.all(12.0),
                      color: Colors.amber,
                      child: Center(child: Text(index.toString())),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
