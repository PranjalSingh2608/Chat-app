import 'package:flutter/material.dart';

import '../views/Home_View.dart';
import '../views/Profile_Info.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 139, 62, 47),
      actions: <Widget>[
        PopupMenuButton<int>(
          onSelected: (item) => handleClick(item),
          color: Color.fromARGB(255, 255, 236, 232),
          itemBuilder: (context) => [
            PopupMenuItem<int>(
                value: 0,
                child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Home_view()));
                    },
                    child: Text('Home'))),
            PopupMenuItem<int>(
                value: 1,
                child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Profile()));
                    },
                    child: Text('Profile'))),
          ],
        ),
      ],
    );
  }

  void handleClick(int item) {
    switch (item) {
      case 0:
        break;
      case 1:
        break;
    }
  }
}
