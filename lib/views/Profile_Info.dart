import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/appbar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late DatabaseReference dbref;
  @override
  void initState(){
    dbref = FirebaseDatabase.instance
        .ref()
        .child("Root")
        .child('User Info')
        .child(FirebaseAuth.instance.currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 236, 232),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56), child: MyAppBar()),
      body: Form(
        child: Builder(builder: (context) {
          return Center(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Name:",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      SharedPreferences.getInstance().then((prefs) {
                        return prefs.getString('name');
                      }).toString(),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
