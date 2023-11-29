import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';

import 'Databaseclassv2.dart';

class EditCard extends StatefulWidget {
  // final int cardIndex;
  final Map currentCard;

  const EditCard({Key? key, required this.currentCard}) : super(key: key);

  @override
  State<EditCard> createState() => _EditCardState();
}

class _EditCardState extends State<EditCard> {
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

  GlobalKey<FormState> key_editCard = GlobalKey();
  TextEditingController controller_Name = TextEditingController();
  TextEditingController controller_Company = TextEditingController();
  TextEditingController controller_Email = TextEditingController();
  TextEditingController controller_Phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller_Name.text = widget.currentCard['NAME'] ?? '';
    controller_Company.text = widget.currentCard['COMPANY'] ?? '';
    controller_Email.text = widget.currentCard['EMAIL'] ?? '';
    controller_Phone.text = widget.currentCard['PHONE'] ?? '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Edit Card"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white70,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: ListView(
              children: [
                Form(
                    key: key_editCard,
                    child: Column(
                      children: [
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
                        SizedBox(
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
                        SizedBox(
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.amberAccent),
                    ),
                      child: const Text("Edit Card", style: TextStyle(color: Colors.black),),
                      onPressed: () async {
                        await mydb.update('''UPDATE FILE1 SET 
                      'NAME' = '${controller_Name.text}',
                      'COMPANY' = '${controller_Company.text}',
                      'EMAIL' = '${controller_Email.text}',
                      'PHONE' = '${controller_Phone.text}' 
                      WHERE ID = ${widget.currentCard['ID']} ''');
                        ReadingData();
                        setState(() {});
                        Fluttertoast.showToast(
                          msg: "Card Edited!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                        );
                        Navigator.pop(context);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
