import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'AddNote.dart';
import 'MyWidgets.dart';
import 'SignIn.dart';

String username = "";
String phone = "";

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  User? _user;
  Map<String, dynamic>? _userData;
  String _selectedPriority = '.';

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  //////////////////////////////////////////////////////////////////////////////

  Future<void> _getUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        _user = user;
        _userData = userData.data();
        username = _userData!['name'];
        phone = _userData!['phone'];
      });
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();

      // Show a success toast message
      Fluttertoast.showToast(
        msg: "Sign Out Successful!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      print("Failed to sign out: $e");

      // Show an error toast message
      Fluttertoast.showToast(
        msg: "Failed to Sign Out: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  //////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    ///
    /// We retrieved the data from the specific user from the user_notes collection
    /// and saved it in an instance called userNotes
    /// then later in the stream builder we will manage it as a snapshot
    /// and turn it to a list for viewing
    ///
    CollectionReference userNotes = FirebaseFirestore.instance
        .collection('users')
        .doc(_user?.uid)
        .collection('user_notes');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorsPrimary,
        title: textPageTitle("Welcome ${_user?.displayName}"),
        centerTitle: true,
      ),
      endDrawer: Drawer(
        child: Container(
          color: Colors.white70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UserAccountsDrawerHeader(
                accountName: _userData != null
                    ? Text("${_userData!['name']}")
                    : const Text("Tester"),
                accountEmail: _userData != null
                    ? Text("${_userData!['email']}")
                    : const Text("test@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  child: const CircleAvatar(
                    radius: 37,
                    backgroundColor: Colors.white70,
                  ),
                ),
                decoration: BoxDecoration(color: colorsPrimary),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.list_alt_rounded, color: colorsPrimary),
                title: Text(
                  "Sign Out",
                  style: TextStyle(color: colorsPrimary),
                ),
                onTap: () {
                  signOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignIn()),
                  );
                },
              ),
              const Divider(),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Remove the search bar
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropdownButtonFormField<String>(
              value: _selectedPriority,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPriority = newValue!;
                });
              },
              items: ['.', '.Low', '.Medium', '.High']
                  .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
              decoration: const InputDecoration(
                icon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            ///
            /// we StreamBuilder since it keeps checking and updating with any new data added or deleted
            /// by doing that the data was uploaded and shown without any issues
            ///
            child: StreamBuilder(
              stream: userNotes.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  List<DocumentSnapshot> documents = snapshot.data!.docs;

                  List<MapEntry<String, dynamic>> noteList =
                      documents.map((doc) {
                    return MapEntry<String, dynamic>(doc.id, doc.data());
                  }).toList();

                  List<MapEntry<String, dynamic>> filteredList = noteList
                      .where((entry) => entry.value["priority"]
                          .toString()
                          .toLowerCase()
                          .contains(_selectedPriority.toString().toLowerCase()))
                      .toList();

                  return ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: colorsNote,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                color: Colors.white70,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading:
                                          const Icon(Icons.edit_note_outlined),
                                      title: Text(
                                          "Note ${index + 1} - Priority: ${filteredList[index].value["priority"]}"),
                                      subtitle: Text(
                                          "${filteredList[index].value["note"]}"),
                                      trailing: IconButton(
                                          onPressed: () {
                                            userNotes
                                                .doc(filteredList[index].key)
                                                .delete()
                                                .then(
                                              (value) {
                                                print(
                                                    "Note deleted successfully");
                                              },
                                            ).catchError(
                                              (error) {
                                                print(
                                                    "Failed to delete note: $error");
                                              },
                                            );
                                          },
                                          icon: const Icon(Icons.delete)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textLargeTitle("Searching for notes..."),
                          const CircularProgressIndicator()
                        ]),
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorsPrimary,
        onPressed: () {
          // Navigate to AddNotes page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNote()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
