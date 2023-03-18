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