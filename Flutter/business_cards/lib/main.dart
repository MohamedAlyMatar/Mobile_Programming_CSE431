import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import 'AddCard.dart';
import 'Databaseclassv2.dart';
import 'EditCard.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //////////////////////////////////////////////////////////////////////////////

  Databasev2 mydb = Databasev2();
  List<Map> mylist = [];

  Future<Database?> ReadingData() async {
    List<Map> RESPONSE = await mydb.reading('''SELECT * FROM 'FILE1' ''');
    mylist = [];
    mylist.addAll(RESPONSE);
    setState(() {});
  }

  //////////////////////////////////////////////////////////////////////////////

  @override
  void initState() {
    ReadingData();
    super.initState();
    mydb.checkdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Business Cards"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amberAccent,
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddCard()))
              .then((value) => ReadingData());
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: mylist.length,
          itemBuilder: (context, index) {
            return ListTile(
              trailing: IconButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditCard(
                                  currentCard: mylist[index],
                                ))).then((value) => ReadingData());
                  },
                  icon: Icon(Icons.edit)),
              leading: IconButton(
                  onPressed: () async {
                    await mydb.delete(
                        '''DELETE FROM file1 WHERE ID = ${mylist[index]['ID']} ''');
                    mylist.removeWhere(
                        (element) => element['ID'] == mylist[index]['ID']);
                    setState(() {});
                    Fluttertoast.showToast(
                      msg: "Card Deleted!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                    );
                  },
                  icon: Icon(Icons.delete)),
              title: Text(mylist[index]['NAME']),
              subtitle: Text(mylist[index]['COMPANY']),
            );
          }),
    );
  }
}
