import 'package:echo_utils/echo_utils.dart';
import 'package:flutter/cupertino.dart';
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
      debugShowCheckedModeBanner: false,
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

  double currentScale = 1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("haha"),),
      body:  Center(child: EchoDragContainer(child: const Icon(CupertinoIcons.airplane,size: 100,color: Colors.deepPurpleAccent,),onTap: (){
        echoLog("点击事件发生!");
      },)),
      // body: GestureDetectorDemo(),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             CupertinoTextField(
               decoration: const BoxDecoration(color: Colors.white),

              suffix: IconButton(onPressed: (){

              }, icon: const Icon(Icons.clear_rounded)),
              maxLines: 5,
            ),
            EchoButton(buttonName: 'echoButton', onPressed: () {
              List<BottomSheetModel> modes = [
                BottomSheetModel(title: "title", onPressed: (context){},preWidget: const Icon(Icons.add)),
                BottomSheetModel(title: "title2", onPressed: (context){}),
              ];
              echoBottomSheet(context, modes);
            },),
            EchoButton(buttonName: "toast", onPressed: (){
              echoToast("出现异常", context,location: ToastLocation.center);
            }),
            Icon(CupertinoIcons.airplane,size: 30,color: Colors.deepPurpleAccent,),
            Expanded(child: const EchoDragContainer(child: Icon(CupertinoIcons.airplane,size: 30,color: Colors.deepPurpleAccent,))),
          ],
        ),
      ),
    );
  }
}
