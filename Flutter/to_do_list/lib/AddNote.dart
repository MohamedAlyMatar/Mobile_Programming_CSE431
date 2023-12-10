import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'MyWidgets.dart';
import 'home.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _controllerNote = TextEditingController();
  double boxHeight = 30.0;
  String _selectedPriority = '.Low';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorsPrimary,
        leading: iconBack(context),
        title: textPageTitle("Add Notes"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: boxHeight),
                        DropdownButtonFormField<String>(
                          value: _selectedPriority,
                          onChanged: (value) {
                            setState(() {
                              _selectedPriority = value!;
                            });
                          },
                          items: ['.Low', '.Medium', '.High']
                              .map<DropdownMenuItem<String>>(
                                (String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                ),
                              )
                              .toList(),
                          decoration: const InputDecoration(
                            icon: Icon(Icons.priority_high),
                            filled: true,
                            fillColor: Colors.white70,
                            hintText: "Select Priority",
                          ),
                        ),
                        SizedBox(height: boxHeight),
                        TextFormField(
                          controller: _controllerNote,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.edit_note_outlined),
                            filled: true,
                            fillColor: Colors.white70,
                            hintText: "ex: study for mobile quiz...",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ("Can't be Empty");
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: boxHeight),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(colorsPrimary!),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        // Get the current user
                        final user = FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          ///
                          /// for adding the data to firestore, we created an instance called notes
                          /// where we will define the path or location (whatever you call it)
                          /// that we will save our note data in
                          /// first the collection called 'users'
                          /// then the current user ID to save the notes to each user separately
                          /// then a collection called 'user_notes' where all the current user notes will be added
                          ///
                          /// YOU CAN DESIGN YOUR OWN STRUCTURE FREELY AS YOU LIKE
                          ///
                          CollectionReference notes = FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.uid) // Use the user's ID
                              .collection('user_notes');
                          await notes.add({
                            "note": _controllerNote.text,
                            "priority": _selectedPriority,
                          });

                          // clear and reset
                          _controllerNote.clear();
                          setState(() {
                            _selectedPriority = '.Low';
                          });
                        }
                      } catch (e) {
                        print("Error adding note to Firestore: $e");
                      }
                    }
                  },
                  child: textButtons("Add Note"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
