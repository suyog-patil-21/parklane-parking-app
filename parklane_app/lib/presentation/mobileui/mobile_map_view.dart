import 'package:flutter/material.dart';
import 'package:parklane_app/presentation/widgets/floating_custom_map.dart';
import 'package:parklane_app/presentation/widgets/map_widget.dart';

import '../widgets/bottom_search_bar.dart';

class MobileMapView extends StatelessWidget {
  const MobileMapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    // final appBarHeight = AppBar().preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      // bottomNavigationBar: CustomBottomSearchBar(screenSize: screenSize),
      floatingActionButton: CustomFloatingButton(screenSize: screenSize),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      body: Stack(
        children: [
          MapWidget(),
          //FLoating list Display
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                false
                    ? Container(
                        margin: const EdgeInsets.all(6),
                        padding: EdgeInsets.zero,
                        height: 150,
                        // color: Colors.yellowAccent,
                        child: PageView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: const EdgeInsets.all(12.0),
                                color: Colors.amber,
                                child: Center(child: Text(index.toString())),
                              );
                            }),
                      )
                    : Container(),
                CustomBottomSearchBar(screenSize: screenSize)
              ],
            ),
          )
        ],
      ),
    );
  }
}
