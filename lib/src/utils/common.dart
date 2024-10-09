import 'dart:math';

import 'package:flutter/material.dart';

/// FileName common
///
/// @Author LinGuanYu
/// @Date 2023/3/16 09:18
///
/// @Description TODO

bool get isRelease => const bool.fromEnvironment("dart.vm.product");

void unFocus() {
/// 使用下面的方式，会触发不必要的build。
/// FocusScope.of(context).unFocus();
/// https://blog.csdn.net/iotjin
FocusManager.instance.primaryFocus?.unfocus();
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}


///随机颜色
Color randomColor() {
  Random random = Random();
  int red = random.nextInt(256); // 0-255之间的随机红色值
  int green = random.nextInt(256); // 0-255之间的随机绿色值
  int blue = random.nextInt(256); // 0-255之间的随机蓝色值
  return Color.fromARGB(255, red, green, blue); // 创建Color对象
}

///@title closeKeyBoard
///@description TODO
///@param: context
///@updateTime 2023/11/28 17:21
///@author LinGuanYu
 closeKeyBoard(BuildContext context){

   FocusScopeNode currentFocus = FocusScope.of(context);
   if (!currentFocus.hasPrimaryFocus &&
       currentFocus.focusedChild != null) {
     FocusManager.instance.primaryFocus?.unfocus();
   }
 }