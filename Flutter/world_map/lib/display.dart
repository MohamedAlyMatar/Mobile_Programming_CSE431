import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class display extends StatefulWidget {
  const display({Key? key}) : super(key: key);

  @override
  State<display> createState() => _displayState();
}

class _displayState extends State<display> {
  Map myreceiveddata = {};

  @override
  Widget build(BuildContext context) {
    myreceiveddata = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Real Time Data for ${myreceiveddata['Location']} '),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Icon(
              Icons.location_city_rounded,
              size: 84.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
                color: Colors.green,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "For ${myreceiveddata['Location']}:\nThe Time is ${myreceiveddata['Time']} \nThe Temperature is ${myreceiveddata['Temp']}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          )
        ],
      )),
    );
  }
}
