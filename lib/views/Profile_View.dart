import 'package:chat/views/Home_View.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../widgets/appbar.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

var name = new TextEditingController();
var note = new TextEditingController();
var profession = new TextEditingController();

class Profile_view extends StatefulWidget {
  const Profile_view({super.key});

  @override
  State<Profile_view> createState() => _Profile_viewState();
}

class _Profile_viewState extends State<Profile_view> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  File? image;
  Future pickImage(ImageSource channel) async {
    try {
      final image = await ImagePicker().pickImage(source: channel);
      if (image == null) {
        return AssetImage("assets/images/defaultprofile.png");
      } else {
        final imageTemp = File(image.path);
        setState(() => this.image = imageTemp);
      }
    } on PlatformException catch (e) {
      Fluttertoast.showToast(
          msg: "Failed to pick image:$e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Color.fromARGB(255, 139, 62, 47),
          textColor: Colors.white);
    }
  }

  late DatabaseReference dbref;
  @override
  void initState() {
    dbref = FirebaseDatabase.instance
        .ref()
        .child("Root")
        .child('User Info')
        .child(FirebaseAuth.instance.currentUser!.uid);
    saveInputs();
    super.initState();
  }

  void saveInputs() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('name', name.text);
      prefs.setString('profession', profession.text);
      prefs.setString('note', note.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 236, 232),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: <Widget>[
            imageProfile(),
            SizedBox(
              height: 20,
            ),
            nameField(),
            SizedBox(
              height: 20,
            ),
            professionField(),
            SizedBox(
              height: 20,
            ),
            noteField(),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            setProfile(),
          ],
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Stack(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: image == null
                  ? AssetImage("assets/images/defaultprofile.png")
                  : FileImage(File(image!.path)) as ImageProvider,
            ),
            Positioned(
                bottom: 10,
                right: 15,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: ((builder) => bottomBox()),
                    );
                  },
                  child: Icon(
                    Icons.camera_alt_rounded,
                    color: Color.fromARGB(255, 139, 62, 47),
                    size: 28.0,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget professionField() {
    return TextFormField(
      controller: profession,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(5, 8, 5, 0),
          prefixIcon: Icon(Icons.badge, color: Color.fromARGB(255, 68, 68, 68)),
          fillColor: Colors.transparent,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: new BorderSide(
              color: Colors.transparent,
              width: 1.0,
            ),
          ),
          labelText: "profession",
          labelStyle: TextStyle(color: Color.fromARGB(255, 68, 68, 68)),
          hintText: "Enter your Profession",
          hintStyle: TextStyle(
            color: Color.fromARGB(255, 68, 68, 68),
          )),
    );
  }

  Widget nameField() {
    return TextFormField(
      controller: name,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(5, 8, 5, 0),
          prefixIcon:
              Icon(Icons.perm_identity, color: Color.fromARGB(255, 68, 68, 68)),
          fillColor: Colors.transparent,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: new BorderSide(
              color: Colors.transparent,
              width: 1.0,
            ),
          ),
          labelText: "Name",
          labelStyle: TextStyle(color: Color.fromARGB(255, 68, 68, 68)),
          hintText: "Enter your Name",
          hintStyle: TextStyle(
            color: Color.fromARGB(255, 68, 68, 68),
          )),
    );
  }

  Widget noteField() {
    return TextFormField(
      maxLines: 4,
      controller: note,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(5, 8, 5, 0),
          prefixIcon: Icon(Icons.info, color: Color.fromARGB(255, 68, 68, 68)),
          fillColor: Colors.transparent,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: new BorderSide(
              color: Colors.transparent,
              width: 1.0,
            ),
          ),
          labelText: "Note",
          labelStyle: TextStyle(
            color: Color.fromARGB(255, 68, 68, 68),
          ),
          hintText: "Enter your Note",
          hintStyle: TextStyle(
            color: Color.fromARGB(255, 68, 68, 68),
          )),
    );
  }

  Widget bottomBox() {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Column(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.camera_alt,
                    size: 35,
                  ),
                  onPressed: () {
                    pickImage(ImageSource.camera);
                  },
                ),
                Text("Camera"),
              ],
            ),
            SizedBox(
              width: 200,
            ),
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.image, size: 35),
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                  },
                ),
                Text("Gallery"),
              ],
            ),
          ])
        ],
      ),
    );
  }

  Widget setProfile() {
    return InkWell(
      onTap: () async {
        firebase_storage.Reference ref =
            firebase_storage.FirebaseStorage.instance.ref('/profilepics/' +
                DateTime.now().millisecondsSinceEpoch.toString());
        firebase_storage.UploadTask uploadTask = ref.putFile(image!.absolute);
        await Future.value(uploadTask);
        var newUrl = await ref.getDownloadURL();
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString('photo', newUrl.toString());
        });
        Map<String, String> info = {
          'name': name.text,
          'note': note.text,
          'profession': profession.text,
          'profilepic': newUrl.toString()
        };
        dbref.set(info);
        saveInputs();
        Fluttertoast.showToast(
            msg: "Profile created successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Color.fromARGB(255, 139, 62, 47),
            textColor: Colors.white);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return Home_view();
        }));
      },
      child: AnimatedContainer(
        width: 120,
        height: 50,
        duration: Duration(milliseconds: 500),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: const Text(
            "SET",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 139, 62, 47),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
