/// FileName echo_toast
///
/// @Author LinGuanYu
/// @Date 2023/3/16 11:32
///
/// @Description TODO

import 'package:flutter/material.dart';

void openPageByFade(BuildContext context, Widget page,
    {bool isReplace = false,
      bool opaque = true,
      Function(dynamic value)? dismissCallBack}) {
  PageRouteBuilder pageRouteBuilder =  PageRouteBuilder(
      opaque: opaque,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        //目标页面
        return page;
      },
      transitionDuration: const Duration(milliseconds: 800),
      transitionsBuilder: (BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,) {
        //渐变过渡动画
        return FadeTransition(
          // 透明度从 0.0-1.0
          opacity: Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              //动画曲线规则，这里使用的是先快后慢
              curve: Curves.fastOutSlowIn,
            ),
          ),
          child: child,
        );
      });
  if (isReplace) {
    Navigator.of(context).pushReplacement(pageRouteBuilder);
  } else {
    Navigator.of(context).push(pageRouteBuilder).then((value) {
      if (dismissCallBack != null) {
        dismissCallBack(value);
      }
    });
  }
}


void echoToast(String message,BuildContext context,{ToastLocation location = ToastLocation.center}){
  /// 根据消息长度决定自动消失时间
  // double multiplier = .5;
  // int timeInSecForIos = (multiplier * (message.length * 0.06 + 0.5)).round();
  openPageByFade(context, EchoToastPage(message: message,
    backgroundColor: Colors.black54,
    textColor: Colors.white,
    isBackgroundDimiss: true,
    location: location,
    duration: 3,
  ),opaque: false);
}


enum ToastLocation {
  top,
  bottom,
  center,
}
class EchoToastPage extends StatefulWidget {
  ///显示的标题
  final String message;
  ///点击背景是否消失
  ///是否拦截Android设备的后退物理按钮的事件
  /// true 是消失  是不拦截后退按钮
  final bool isBackgroundDimiss;
  final bool isCancleColose;
  final bool isSelectColose;
  final Color? backgroundColor;
  final Color? textColor;
  final ToastLocation? location;
  final int? duration;
  const EchoToastPage({Key? key,
    required this.message,
    this.isBackgroundDimiss = false,
    this.isCancleColose = true,
    this.isSelectColose = true,
    this.duration = 3,
    this.backgroundColor,
    this.location = ToastLocation.center,
    this.textColor,}) : super(key: key);

  @override
  State<EchoToastPage> createState() => _EchoToastPageState();
}

class _EchoToastPageState extends State<EchoToastPage> {
  @override
  Widget build(BuildContext context) {
    Future.delayed( Duration(seconds: widget.duration??3), () {
      Navigator.of(context).pop(true);
    });
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Material(
        type: MaterialType.transparency,
        child: WillPopScope(
          onWillPop: ()async{
            ///这里返回true表示不拦截
            ///返回false拦截事件的向上传递
            return Future.value(widget.isBackgroundDimiss);
          },
          child: GestureDetector(
            ///点击背景消失
            onTap: () {
              if (widget.isBackgroundDimiss) {
                Navigator.of(context).pop();
              }
            },
            ///内容区域
            child: buildBodyContainer(context),
          ),
        ),
      ),
    );
  }

  SizedBox buildBodyContainer(BuildContext context) {
    ///充满屏幕的透明容器
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      ///线性布局的隔离
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: widget.location==ToastLocation.center?MainAxisAlignment.center:widget.location==ToastLocation.top
            ?MainAxisAlignment.start:MainAxisAlignment.end,
        children: [
          if(widget.location==ToastLocation.top)
            const SizedBox(height: 15,),
          ///限制弹框的大小
          ConstrainedBox(
            constraints: const BoxConstraints(
                minHeight: 10,minWidth: 10, maxWidth: 280,),
            child: buildContainer(context),
          ),
          // buildContainer(context),
          if(widget.location==ToastLocation.bottom)
            const SizedBox(height: 15,),

        ],
      ),
    );
  }

  Container buildContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      ///圆角边框设置
      decoration:  BoxDecoration(
          color: widget.backgroundColor??Colors.black54,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      ///弹框标题、内容、按钮 线性排列
      child: Center(
        child:Text(
          widget.message,
          style:  TextStyle(fontSize: 18,color: widget.textColor??Colors.white),
        ),
      ),
    );
  }
}
