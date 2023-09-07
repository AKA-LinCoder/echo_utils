import 'package:echo_utils/echo_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
      home: LoginPage(),
      builder: (context, child) {
        return Stack(
          children: [
            child ?? Container(),
            const Positioned(
                bottom: 20,
                right: 20,
                child: EchoDragContainer(
                  child: Icon(
                    Icons.add,
                    size: 60,
                    color: Colors.red,
                  ),
                ))
          ],
        );
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LoginPage')),
      body: Center(
        child: Column(
          children: [
             EchoRatingStar(
               initSelectStarNum: 3,
               selectCallback: (selected){
              if (kDebugMode) {
                print("选择了$selected");
              }
            },),
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const MyHomePage(
                            title: '',
                          ))),
              child: const Text('Page2'),
            ),
          ],
        ),
      ),
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
      appBar: AppBar(
        title: const Text("haha"),
        actions: [
          WPopupMenu(onValueChanged: (selected){}, actions: const ["复制","转发","删除"],
            menuWidth: 200,menuHeight: 40,pressType: PressType.singleClick, child: Container(color: Colors.black54,child: const Icon(Icons.access_alarm),),)
        ],
      ),
      body: Column(
        children: [
          const EchoLoginInput(),
          const EchoLoginInput(isPassword: true,),
          Center(
              child: EchoDragContainer(
            child: const Icon(
              CupertinoIcons.airplane,
              size: 100,
              color: Colors.deepPurpleAccent,
            ),
            onTap: () {
              echoLog("点击事件发生!");

              return WPopupMenu(onValueChanged: (selected){}, actions: const ["复制","转发","删除"],
                menuWidth: 200,menuHeight: 40,pressType: PressType.singleClick, child: Container(color: Colors.black54,child: const Icon(Icons.access_alarm),),);
            },
            getPositionAndSize: (leftTopPosition, size) {
              echoLog("当前widget的左上角的位置是$leftTopPosition,widget的大小是$size");
            },
          )),
        ],
      ),
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
              suffix: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.clear_rounded)),
              maxLines: 5,
            ),
            EchoButton(
              buttonName: 'echoButton',
              onPressed: () {
                List<BottomSheetModel> modes = [
                  BottomSheetModel(
                      title: "title",
                      onPressed: (context) {},
                      preWidget: const Icon(Icons.add)),
                  BottomSheetModel(title: "title2", onPressed: (context) {}),
                ];
                echoBottomSheet(context, modes);
              },
            ),
            EchoButton(
                buttonName: "toast",
                onPressed: () {
                  echoToast("出现异常", context, location: ToastLocation.center);
                }),
            Icon(
              CupertinoIcons.airplane,
              size: 30,
              color: Colors.deepPurpleAccent,
            ),
            Expanded(
                child: const EchoDragContainer(
                    child: Icon(
              CupertinoIcons.airplane,
              size: 30,
              color: Colors.deepPurpleAccent,
            ))),
          ],
        ),
      ),
    );
  }
}
