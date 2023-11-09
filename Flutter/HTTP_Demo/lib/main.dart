import 'package:flutter/material.dart';
import 'MyCountry.dart';
import 'package:http/http.dart';
import 'dart:convert';

List CountryName = [];
List CountryCurrency = [];

String API = 'https://countriesnow.space/api/v0.1/countries/currency';

Future getdata() async {
  var response = await get(Uri.parse(API));
  Map<String, dynamic> mydata = jsonDecode(response.body);
  List data = mydata['data'];
  CountryName = data.map((e) => e['name']).toList();
  CountryCurrency = data.map((e) => e['currency']).toList();
  return CountryCurrency;
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "My First App",
    home: MyApp(),
    routes: {
      '/home': (context) => MyApp(),
      '/currency': (context) => Mycurrency(),
    },
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lime,
      ),
      body: FutureBuilder(
        future: getdata(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: CountryName.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        print('you selected${CountryName[index]}');
                        //Navigator.pushNamed(context, '/country');
                        Navigator.pushNamed(context, '/currency', arguments: {
                          "Currency": CountryCurrency[index],
                          "Name": CountryName[index]
                        });
                      },
                      title: Text(CountryName[index]),
                      subtitle: Text(CountryCurrency[index]),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
