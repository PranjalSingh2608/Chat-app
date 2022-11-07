import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

import '../widgets/appbar.dart';

class Signup_View extends StatefulWidget {
  const Signup_View({super.key});
  static String verify = "";
  @override
  State<Signup_View> createState() => _Signup_ViewState();
}

class _Signup_ViewState extends State<Signup_View> {
  late DatabaseReference dbref;
  var countryCode = new TextEditingController();
  var phone = new TextEditingController();
  @override
  void initState() {
    //dbref = FirebaseDatabase.instance.ref().child('User Info').child(FirebaseAuth.instance.currentUser!.uid);
    countryCode.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(255, 255, 236, 232),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child:
                          Lottie.asset("assets/animations/verification.json"),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Text(
                        'Phone Number Verification',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: Text(
                        '(Please provide your phone number for otp verification)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 40,
                            child: TextField(
                              controller: countryCode,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Text(
                            "|",
                            style: TextStyle(fontSize: 33, color: Colors.grey),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              controller: phone,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(5, 8, 5, 8),
                                  hintText: "Enter your Phone Number",
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    InkWell(
                      onTap: () async {
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: '${countryCode.text + phone.text}',
                          verificationCompleted:
                              (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {},
                          codeSent: (String verificationId, int? resendToken) {
                            Signup_View.verify = verificationId;
                            Navigator.pushNamed(context, '/verify');
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        width: 120,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            "Send OTP",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 139, 62, 47),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
