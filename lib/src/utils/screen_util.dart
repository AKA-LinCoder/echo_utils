import 'package:flutter_screenutil/flutter_screenutil.dart';

/// FileName screen_util
///
/// @Author LinGuanYu
/// @Date 2023/11/28 09:23
///
/// @Description 封装屏幕适配

class EchoScreenAdapter{
  static width(num v){
    return v.w;
  }

  static height(num v){
    return v.h;
  }

  static fontSize(num v){
    return v.sp;
  }

  static getScreenWidth(){
    return 1.sw;
  }

  static getScreenHeight(){
    return 1.sh;
  }

  static getStatusBarHeight(){
    return ScreenUtil().statusBarHeight;
  }

  static getBottomBarHeight(){
    return ScreenUtil().bottomBarHeight;
  }

}