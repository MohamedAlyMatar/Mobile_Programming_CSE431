import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import 'Databaseclassv2.dart';

class AddCard extends StatefulWidget {
  const AddCard({Key? key}) : super(key: key);

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
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

  GlobalKey<FormState> key_addForm = GlobalKey();
  TextEditingController controller_Name = TextEditingController();
  TextEditingController controller_Company = TextEditingController();
  TextEditingController controller_Email = TextEditingController();
  TextEditingController controller_Phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Add Card"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white70,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: ListView(
              children: [
                Form(
                    key: key_addForm,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                              "Fill in the following fields then add your card",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16)),
                        ),
                        TextFormField(
                          controller: controller_Name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ('you forget your name');
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Name',
                              icon: Icon(Icons.people)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: controller_Company,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ('you forgot your company name');
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Company',
                              icon: Icon(Icons.apartment_rounded)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: controller_Email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ('you forgot your email');
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Email',
                              icon: Icon(Icons.email)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: controller_Phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ('you forgot your number');
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Phone number',
                              icon: Icon(Icons.phone_android)),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.amberAccent),
                          ),
                          child: const Text(
                            "Clear All",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            key_addForm.currentState!.reset();
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.amberAccent),
                          ),
                          child: const Text(
                            "Show All",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.amberAccent),
                          ),
                          child: const Text(
                            "Add Card",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () async {
                            await mydb.write(
                                '''INSERT INTO 'FILE1' ('NAME','COMPANY', 'EMAIL', 'PHONE') VALUES
                                ('${controller_Name.text}',
                                 '${controller_Company.text}',
                                 '${controller_Email.text}',
                                 '${controller_Phone.text}') ''');
                            Fluttertoast.showToast(
                              msg: "Card Added!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                            );
                          }),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
