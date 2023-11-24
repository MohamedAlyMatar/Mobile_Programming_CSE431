import 'package:flutter/material.dart';
import 'package:forms_demo/signUpForm.dart';

class signIN extends StatefulWidget {
  const signIN({super.key});

  @override
  State<signIN> createState() => _signINState();
}

class _signINState extends State<signIN> {
  GlobalKey<FormState> mykey = GlobalKey();
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Hello World"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              const CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1579444741963-5ae219cfe27c?auto=format&fit=crop&q=80&w=2940&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                  key: mykey,
                  child: Column(
                    //Note here that When you have a Column inside a ListView, the ListView will provide the Column with all of the space it needs to layout its children. This is why there is no error in this case.
                    // However, when you have a ListView inside a Column, the Column cannot provide the ListView with a size, because the ListView needs to know how much space it has to scroll before it can be laid out. This is why you will get a Rendering error(RenderBox was not laid out).
                    children: [
                      TextFormField(
                        controller: firstnamecontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ('you forget your username/email');
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Username or Email',
                            icon: Icon(Icons.people)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: emailcontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ('you forgot your password');
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Password',
                            icon: Icon(Icons.lock_outline_rounded)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
              ElevatedButton(
                  child: const Text("Login"),
                  onPressed: () {
                    if (mykey.currentState!.validate()) {
                      print("all is good");
                      mykey.currentState!.reset();
                    }
                  }),
              ElevatedButton(
                  child: const Text("Sign up"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => signUpForm()));
                  })
            ],
          ),
        ));
  }
}
