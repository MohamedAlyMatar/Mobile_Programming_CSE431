import 'package:flutter/material.dart';

class signUpForm extends StatefulWidget {
  const signUpForm({Key? key}) : super(key: key);

  @override
  State<signUpForm> createState() => _signUpFormState();
}

class _signUpFormState extends State<signUpForm> {
  GlobalKey<FormState> mykey = GlobalKey();
  TextEditingController FirstNameCont = TextEditingController();
  TextEditingController LastNameCont = TextEditingController();
  TextEditingController EmailCont = TextEditingController();
  TextEditingController PhoneCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up Form"),
        centerTitle: true,
      ),
      body: Center(
          child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Center(child: Text("Welcome", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.lightBlue),),),
          ),
          Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: mykey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(hintText: "First Name"),
                      controller: FirstNameCont,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ("First Name is Empty");
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Last Name"),
                      controller: LastNameCont,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ("Last Name is Empty");
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Email Address"),
                      controller: EmailCont,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ("Check your Email Address");
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Phone Number"),
                      controller: PhoneCont,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ("Phone Number not entered");
                        } else {
                          return null;
                        }
                      },
                    )
                  ],
                ),
              )),
          Padding(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                if (mykey.currentState!.validate()) {
                  print("YOu signed up successfully :)");
                  mykey.currentState!.reset();
                }
              },
              child: const Text("Sign Up"),
            ),
          )
        ],
      )),
    );
  }
}
