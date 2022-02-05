import 'package:flutter/material.dart';

class DesktopHomeView extends StatelessWidget {
  DesktopHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green,
      body: Container(
        child: Row(
          children: [
            // * SideBar area
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'Parklane',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    TextField(
                      maxLines: 1,
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.search_rounded),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22)),
                          hintText: 'Parking address...'),
                      keyboardType: TextInputType.streetAddress,
                    ),
                    ElevatedButton(onPressed: () {}, child: Text('Press Here')),
                    OutlinedButton(
                        onPressed: () {}, child: Text('outline button')),
                    Divider(),
                    Expanded(
                      child: ListView.builder(
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Text('Label $index'),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
            // * Map Area
            Expanded(
                flex: 6,
                child: Container(
                  color: Colors.green,
                ))
          ],
        ),
      ),
    );
  }
}
