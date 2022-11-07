import 'package:chat/views/Profile_View.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

import '../widgets/appbar.dart';
import 'SignUp_View.dart';

class OTP extends StatefulWidget {
  const OTP({super.key});
  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var code = "";
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
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
                    SizedBox(height: 25),
                    Pinput(
                      length: 6,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: submittedPinTheme,
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      onChanged: (value) {
                        code = value;
                      },
                    ),
                    SizedBox(height: 25),
                    InkWell(
                      onTap: () async {
                        try {
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                                  verificationId: Signup_View.verify,
                                  smsCode: code);

                          await auth.signInWithCredential(credential);
                        } catch (e) {
                          Fluttertoast.showToast(
                              msg: "wrong otp",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Color.fromARGB(255, 139, 62, 47),
                              textColor: Colors.white);
                        }
                         Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Profile_view()));
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        width: 120,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            "VERIFY",
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
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signup_View()));
                            },
                            child: Text(
                              "Edit phone number",
                              style: TextStyle(color: Colors.blue),
                            ))
                      ],
                    )
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
