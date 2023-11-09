import 'package:flutter/material.dart';

class Mycurrency extends StatefulWidget {
  const Mycurrency({super.key});

  @override
  State<Mycurrency> createState() => _MyCountryState();
}

class _MyCountryState extends State<Mycurrency> {
  Map myreceiveddata = {};

  @override
  Widget build(BuildContext context) {
    myreceiveddata = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Text(
          ".....${myreceiveddata['Name']}'s Currency is ${myreceiveddata['Currency']}....",
          style: TextStyle(color: Colors.red, fontSize: 28),
        ),
      ),
    );
  }
}
