import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../widgets/appbar.dart';

class Home_view extends StatefulWidget {
  const Home_view({super.key});

  @override
  State<Home_view> createState() => _Home_viewState();
}

class _Home_viewState extends State<Home_view> {
  Query dbref =
      FirebaseDatabase.instance.ref().child("Root").child('User Info');
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child("Root").child('User Info');
  void initState() {
    dbref = FirebaseDatabase.instance.ref().child("Root").child('User Info');
    super.initState();
  }

  Widget listItem({required Map intro}) {
    return Container(
      height: 150,
      child: Card(
        color: Colors.transparent,
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(radius: 60,child: Image.network(intro['profilepic'])),
                Column(
                  children: [
                    Text(intro['name']),
                    SizedBox(height: 10),
                    Text(intro['profession']),
                    SizedBox(height: 10),
                    Text(intro['note']),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 236, 232),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56), child: MyAppBar()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              child: FirebaseAnimatedList(
                query: dbref,
                itemBuilder: ((BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  Map intro = snapshot.value as Map;
                  intro['key'] = snapshot.key;
                  return listItem(intro: intro);
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
