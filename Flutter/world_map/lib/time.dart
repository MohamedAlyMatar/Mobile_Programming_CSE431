import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class OnlineTime {
  String? Time;
  String? Location;
  String? URL;
  String? Temp;

  OnlineTime({this.Location, this.URL});

  Future<void> getTime() async {
    Response response1 =
        await get(Uri.parse('http://worldtimeapi.org/api/timezone/$URL'));
    Map Data1 = {};
    Data1 = jsonDecode(response1.body);
    DateTime currentTime = DateTime.parse(Data1['datetime']);
    String Locoffsite = Data1['utc_offset'].substring(1, 3);
    currentTime = currentTime.add(Duration(hours: int.parse(Locoffsite)));
    Time = DateFormat.jm().format(currentTime);

    Response response2 = await get(Uri.parse(
        'https://api.weatherapi.com/v1/current.json?key=9ce6148ebf5e45ea990192255230211&q=$Location&aqi=yes'));
    Map Data2 = {};
    Data2 = jsonDecode(response2.body);
    Map currentTemp = Data2['current'];
    Temp = currentTemp['temp_c'].toString();
  }
}

// class OnlineTemp {
//   String? city;
//   String? Temp;
//
//   OnlineTemp({this.city});
//
//   Future<void> getTemp() async {
//     Response response = await get(Uri.parse(
//         'https://api.weatherapi.com/v1/current.json?key=9ce6148ebf5e45ea990192255230211&q=$city&aqi=yes'));
//     Map Data = {};
//     Data = jsonDecode(response.body);
//     Map currentTemp = Data['current'];
//     Temp = currentTemp['temp_c'].toString();
//   }
// }
