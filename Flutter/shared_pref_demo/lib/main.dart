import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double boxHeight = 10.0;
  String? name;
  double? age;
  List<String>? hobbies;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text(
            "Shared Preference Demo",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.tealAccent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: Colors.teal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        text_card("Name: ${name}"),
                        text_card("Age: ${age}"),
                        text_card("Hobbies: ${hobbies}"),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: boxHeight),
                ElevatedButton(
                    onPressed: () async {
                      SharedPreferences myPref = await getPref();
                      myPref.setString('Name', 'Mohamed');
                      myPref.setDouble('Age', 23);
                      myPref
                          .setStringList('Hobbies', ['Swimming', 'Traveling']);
                    },
                    child: Text("Save in Shared Preference")),
                SizedBox(height: boxHeight),
                ElevatedButton(
                    onPressed: () async {
                      SharedPreferences myPref = await getPref();
                      name = myPref.getString('Name');
                      age = myPref.getDouble('Age');
                      hobbies = myPref.getStringList('Hobbies');
                      setState(() {});

                      print(name);
                      print(age);
                      print(hobbies);
                    },
                    child: Text("Print the saved Data")),
                SizedBox(height: boxHeight),
                ElevatedButton(
                    onPressed: () async {
                      SharedPreferences myPref = await getPref();
                      myPref.setString('Name', 'Youssef');
                      setState(() {});
                    },
                    child: Text("Update the Name key in shared preference")),
                SizedBox(height: boxHeight),
                ElevatedButton(
                    onPressed: () async {
                      SharedPreferences myPref = await getPref();
                      myPref.clear();
                      setState(() {});
                    },
                    child: Text("Reset the whole Data")),
                SizedBox(height: boxHeight),
                ElevatedButton(
                    onPressed: () async {
                      SharedPreferences myPref = await getPref();
                      myPref.remove('Hobbies');
                      setState(() {});
                    },
                    child: Text("Deleting the Hobbies"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<SharedPreferences> getPref() async {
    SharedPreferences myPref = await SharedPreferences.getInstance();
    return myPref;
  }
  Widget text_card(String text){
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    );
  }
}
