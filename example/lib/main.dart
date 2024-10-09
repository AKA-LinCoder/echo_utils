import 'package:echo_utils/echo_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

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

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _showBottomSheet();
    });
  }


  void _showBottomSheet (){
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      // useSafeArea: true,
      context: context,
      builder: (BuildContext sheetContext) {
        return Container(

          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('权限申请'),
              SizedBox(height: 16.0),
              Text('App需要相机权限以正常使用，请点击同意按钮以授予权限。'),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(sheetContext).pop(); // 关闭底部表单
                  Permission.camera.request().then((status) {
                    if (status.isGranted) {
                      _performLogin();
                    } else {
                      // 用户拒绝了权限，可以在这里处理相应的操作，如退出应用或显示提示信息
                      print('用户拒绝了相机权限');
                    }
                  });
                },
                child: Text('同意'),
              ),
            ],
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LoginPage')),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){

                  // _showPermissionBottomSheet(context);
                  // _showPermissionDialog(context);
                },
                child: Text("权限申请")),
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

  void _performLogin() {
    // 在这里执行登录操作
    print('用户已登录');
  }

  void _showPermissionBottomSheet(BuildContext context) {
    Permission.camera.request().then((status) {
      if (status.isGranted) {
        // 用户已经同意权限，可以进行正常操作
        _performLogin();
      } else {
        // 弹出权限申请底部表单
        showBottomSheet(
          context: context,
          builder: (BuildContext sheetContext) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('权限申请'),
                  SizedBox(height: 16.0),
                  Text('App需要相机权限以正常使用，请点击同意按钮以授予权限。'),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(sheetContext).pop(); // 关闭底部表单
                      Permission.camera.request().then((status) {
                        if (status.isGranted) {
                          _performLogin();
                        } else {
                          // 用户拒绝了权限，可以在这里处理相应的操作，如退出应用或显示提示信息
                          print('用户拒绝了相机权限');
                        }
                      });
                    },
                    child: Text('同意'),
                  ),
                ],
              ),
            );
          },
        );
      }
    });
  }

  Future<void> _showPermissionDialog(BuildContext context) async {
    var status = await Permission.camera.status;
    if (status.isGranted) {
      // 用户已经同意权限，可以进行正常操作
      _performLogin();
    } else {
      if(!context.mounted){
        return;
      }
      // 弹出权限申请框
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) => AlertDialog(
          title: const Text('权限申请'),
          content: const Text('App需要相机权限以正常使用，请点击同意按钮以授予权限。'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                if(!dialogContext.mounted){
                  return;
                }
                Navigator.of(dialogContext).pop();  // 使用 dialogContext
                status = await Permission.camera.request();
                if (status.isGranted) {
                  _performLogin();
                } else {
                  // 用户拒绝了权限，可以在这里处理相应的操作，如退出应用或显示提示信息
                  if (kDebugMode) {
                    print('用户拒绝了相机权限');
                  }
                }
              },
              child: const Text('同意'),
            ),
          ],
        ),
      );
    }
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
