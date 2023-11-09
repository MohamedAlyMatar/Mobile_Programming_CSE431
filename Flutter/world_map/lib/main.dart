import 'package:flutter/material.dart';
import 'package:world_map/time.dart';
import 'display.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "My First App",
    home: MyApp(),
    routes: {
      '/home': (context) => MyApp(),
      '/display': (context) => display(),
    },
  ));
}

List<OnlineTime> countrylist = [
  OnlineTime(Location: 'Egypt', URL: '/Africa/cairo'),
  OnlineTime(Location: 'Dubai', URL: '/Asia/Dubai'),
  OnlineTime(Location: 'Colombo', URL: '/Asia/Colombo'),
  OnlineTime(Location: 'Hong Kong', URL: '/Asia/Hong_Kong'),
  OnlineTime(Location: 'London', URL: '/Europe/London'),
  OnlineTime(Location: 'Moscow', URL: '/Europe/Moscow'),
  OnlineTime(Location: 'Berlin', URL: '/Europe/Berlin'),
  OnlineTime(Location: 'Tokyo', URL: '/Asia/Tokyo'),
  OnlineTime(Location: 'Paris', URL: '/Europe/paris'),
  OnlineTime(Location: 'Johannesburg', URL: '/Africa/Johannesburg'),
];

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? Time = "Loading-Time";
  String? Location = "Loading-Location";
  String? URL = "Loading-URL";
  String? Temp = "Loading-Temp";

  Future<void> FromOnlineTimeClassWithIndex(index) async {
    OnlineTime myTime = countrylist[index];
    await myTime.getTime();
    Time = myTime.Time;
    Location = myTime.Location;
    URL = myTime.URL;
    Temp = myTime.Temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("World Map (Real Time and Temp)"),
      ),
      body: ListView.builder(
        itemCount: countrylist.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              child: ListTile(
                onTap: () async {
                  await FromOnlineTimeClassWithIndex(index);
                  // await FromOnlineTempClassWithIndex(index);
                  print('------------------- you selected ${countrylist[index].Location} -------------------');
                  Navigator.pushNamed(context, '/display', arguments: {
                    "Location": Location,
                    "URL": URL,
                    "Time": Time,
                    "Temp": Temp,
                  });
                },
                title: Text(countrylist[index].Location!),
                trailing: Text("Show Time and Temp"),
                leading: Icon(Icons.pin_drop_sharp),
              ),
            ),
          );
        },
      ),
    );
  }
}
