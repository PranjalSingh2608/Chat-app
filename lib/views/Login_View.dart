import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../widgets/appbar.dart';

class Login_view extends StatefulWidget {
  const Login_view({super.key});

  @override
  State<Login_view> createState() => _Login_viewState();
}

class _Login_viewState extends State<Login_view> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(255, 255, 236, 232),
      child: Scaffold(
      ),
    );
  }
}
