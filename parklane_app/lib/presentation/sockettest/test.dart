import 'dart:math';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ParkingTest extends StatefulWidget {
  const ParkingTest({Key? key}) : super(key: key);

  @override
  _ParkingTestState createState() => _ParkingTestState();
}

class _ParkingTestState extends State<ParkingTest> {
  late IO.Socket socket;
  String messagefrombackend = '';
  @override
  void initState() {
    socketinit();
    super.initState();
    // fetchStatus();
  }

  void socketinit() {
    //  ip of the pc :192.168.0.56
    socket = IO.io(
        'http://localhost:3000',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .build());
    // * To Connect mannually
    socket.connect();

    socket.onConnect((_) {
      print('connect');
    });
  }

  void fetchStatus() {
    print('Inside Fetch');
    socket.emit('fetchStatus', 'status');
    socket.on('parkstatus', (data) {
      messagefrombackend = data as String;
      print('DATA : ${data}\n\t ${data.runtimeType}');
    });
  }

  Stream<int> getRandom() async* {
    var random = 0;
    while (true) {
      await Future.delayed(Duration(milliseconds: 1000));
      yield ++random;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(
          onPressed: () {
            setState(() {
              fetchStatus();
            });
          },
          child: Text('fetch and Set')),
      // Text(messagefrombackend),
      // StreamBuilder(
      //     stream: getRandom(),
      //     builder: (context, AsyncSnapshot<int> snapshot) {
      //       if (snapshot.connectionState == ConnectionState.active) {
      //         print('active');
      //       } else if (snapshot.connectionState == ConnectionState.done) {
      //         print('done');
      //       } else if (snapshot.connectionState == ConnectionState.waiting) {
      //         print('waiting');
      //       } else if (snapshot.connectionState == ConnectionState.none) {
      //         print('none');
      //       } else {
      //         print('somethings else');
      //       }
      //       return Text('${snapshot.data}');
      //     }),
      Text('Parking1 : Staus'),
      Text('Parking2 : Staus'),
      Text('Parking3 : Staus'),
      Text('Parking4 : Staus'),
    ]);
  }
}
