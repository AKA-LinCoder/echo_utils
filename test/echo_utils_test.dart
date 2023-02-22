

import 'package:echo_utils/echo_utils.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EchoButton(buttonName: "buttonName", onPressed: (){}),
      ],
    );
  }
}
