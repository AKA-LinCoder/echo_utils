<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

一些简单widget，方便少写代码

## Features

封装了一些简单widget

## Getting started

import 'packages:echo_utils/echo_utils.dart'

## Usage 简单使用

```dart
import 'package:echo_utils/echo_utils.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            EchoButton(buttonName: 'echoButton', onPressed: () {
              List<BottomSheetModel> modes = [
                BottomSheetModel(title: "title", onPressed: (){},preWidget: const Icon(Icons.add)),
                BottomSheetModel(title: "title2", onPressed: (){}),
              ];
              echoBottomSheet(context, modes);
            },),
          ],
        ),
      ),
    );
  }
}

```

## Additional information

欢迎大家使用提出建议
